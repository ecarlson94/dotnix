{
  config,
  lib,
  ...
}:
with lib; let
  inherit (config.media) stateDir;

  domain = "radarr.${config.networking.domain}";
  cfg = config.media.radarr;
in {
  options.media.radarr = {enable = mkEnableOption "Radarr movie download organizer";};

  config = mkIf cfg.enable {
    # Radarr setup
    services.radarr = {
      enable = true;
      dataDir = "${stateDir}/radarr";
    };

    # Nginx reverse proxy with HTTPS
    services.nginx.virtualHosts.${domain} = {
      forceSSL = true;
      enableACME = true;
      locations."/" = {
        proxyPass = "http://localhost:7878";
        proxyWebsockets = true;
      };
    };

    # Cloudflare CNAME entry
    media.cloudflareCNAMEs.records.radarr = {};
  };
}
