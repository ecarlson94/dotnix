{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.media.nginx;
in {
  options.media.nginx = {enable = mkEnableOption "nginx";};

  config = mkIf cfg.enable {
    services.nginx = {
      enable = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;

      # Central ACME definition
      virtualHosts."default" = {
        enableACME = true;
        acmeRoot = "/var/www";
      };
    };

    security.acme = {
      acceptTerms = true;
      defaults.email = "media@walawren.com";
    };
  };
}
