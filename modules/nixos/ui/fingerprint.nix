{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.ui.fingerprint;
in {
  options.ui.fingerprint = {enable = mkEnableOption "fingerprint";};

  config = mkIf cfg.enable {
    services.fprintd.enable = true;

    security.pam.services = {
      login.fprintAuth = true;
      sudo.fprintAuth = true;
    };
  };
}
