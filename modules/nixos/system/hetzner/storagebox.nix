{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  options.system.hetzner.storagebox = mkOption {
    type = types.attrsOf (types.submodule ({hostname, ...}: {
      options = {
        enable = mkEnableOption "Enable rclone mount for this Storage Box";

        user = mkOption {
          type = types.str;
          description = "Hetzner Storage Box username (e.g., u123456)";
        };

        host = mkOption {
          type = types.str;
          description = "Hetzner Storage Box hostname (e.g., u123456.your-storagebox.de)";
        };

        mountPoint = mkOption {
          type = types.path;
          default = "/mnt/storagebox-${hostname}";
          description = "Where the rclone remote should be mounted";
        };

        keySecret = mkOption {
          type = types.str;
          description = "SOPS secret name that contains the private SSH key";
        };

        remotePath = mkOption {
          type = types.str;
          default = "/${hostname}";
          description = ''
            Remote subdirectory to mount from the Storage Box.
            Defaults to a per-client path using this machine's hostname.
          '';
        };
      };
    }));
    default = {};
    description = "Declarative Hetzner Storage Box mounts using rclone";
  };

  config = mkIf (config ? system.hetzner.storagebox) {
    environment.systemPackages = [pkgs.rclone];

    assertions = [
      {
        assertion = let
          used =
            map (x: "${x.host}:${x.remotePath}")
            (attrValues config.system.hetzner.storagebox);
        in
          unique used == used;
        message = "Duplicate host+remotePath combinations in storagebox config.";
      }
    ];

    systemd.tmpfiles.rules = flatten (
      map (boxCfg: ["d ${boxCfg.mountPoint} 0755 root root - -"])
      (attrValues config.system.hetzner.storagebox)
    );

    systemd.services =
      mapAttrs' (
        hostname: boxCfg:
          nameValuePair "rclone-storagebox-${hostname}" (mkIf boxCfg.enable {
            description = "Rclone mount for Hetzner Storage Box ${hostname}";
            after = ["network-online.target"];
            wants = ["network-online.target"];
            wantedBy = ["multi-user.target"];

            serviceConfig = {
              ExecStart = ''
                ${pkgs.rclone}/bin/rclone mount \
                  sftp:${boxCfg.user}@${boxCfg.host}:${boxCfg.remotePath} \
                  ${boxCfg.mountPoint} \
                  --sftp-identity-file ${config.sops.secrets.${boxCfg.keySecret}.path} \
                  --allow-other \
                  --dir-cache-time 336h \
                  --vfs-cache-mode full \
                  --vfs-cache-max-size 250G \
                  --vfs-cache-max-age 24h \
                  --buffer-size 256M \
                  --poll-interval 0 \
                  --attr-timeout 9999h \
                  --no-modtime \
                  --multi-thread-streams 4 \
                  --umask 002
              '';
              ExecStop = "${pkgs.fuse}/bin/fusermount -u ${boxCfg.mountPoint}";
              Restart = "always";
              RestartSec = "10s";
              Type = "notify";
              KillMode = "control-group";
            };
          })
      )
      config.system.hetzner.storagebox;
  };
}
