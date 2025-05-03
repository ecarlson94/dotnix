{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.media.cloudflareCNAMEs;

  expandedRecords =
    mapAttrsToList
    (name: opts: {
      zone = opts.zone or config.networking.domain;
      record = opts.record or "${name}.${config.networking.domain}";
      target = opts.target or config.networking.domain;
      proxied = opts.proxied or true;
    })
    cfg.records;

  cnameRecordsJson = pkgs.writeText "cloudflare-cname-records.json" (builtins.toJSON expandedRecords);
  updateScript = pkgs.writeShellScriptBin "update-cnames" ''
    export CF_API_TOKEN=$(cat /run/secrets/cloudflare-token)
    exec ${pkgs.python3}/bin/python3 ${./update-cnames.py} ${cnameRecordsJson}
  '';
in {
  options.media.cloudflareCNAMEs = {
    enable = mkEnableOption "Cloudflare CNAME updater on rebuild";

    records = mkOption {
      type = with types;
        attrsOf (submodule {
          options = {
            zone = mkOption {
              type = types.str;
              default = config.networking.domain;
              description = "The DNS zone (default: networking.domain)";
            };
            record = mkOption {
              type = types.nullOr types.str;
              default = null;
              description = "The full CNAME record (default: <key>.domain)";
            };
            target = mkOption {
              type = types.str;
              default = config.networking.domain;
              description = "The CNAME target (default: networking.domain)";
            };
            proxied = mkOption {
              type = types.bool;
              default = true;
              description = "Whether to enable Cloudflare proxying for this record.";
            };
          };
        });
      default = {};
      description = "Map of service names to Cloudflare CNAME record settings.";
    };
  };

  config = mkIf cfg.enable {
    sops.secrets.cloudflare-api-token = {
      owner = "root";
      mode = "0400";
    };

    environment.systemPackages = [updateScript];

    system.activationScripts.cloudflareCNAMEs = {
      text = ''
        echo "Applying Cloudflare CNAME records..."
        export CF_API_TOKEN=$(cat ${config.sops.secrets.cloudflare-api-token.path})
        ${updateScript}/bin/update-cnames
      '';
    };
  };
}
