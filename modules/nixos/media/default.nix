{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.media;
in {
  imports = [
    ./cnames
    ./nginx.nix
    ./radarr.nix
    ./shared-options.nix
  ];

  options.media = {enable = mkEnableOption "media";};

  config = mkIf cfg.enable {
    media = {
      cloudflareCNAMEs.enable = true;
      nginx.enable = false;

      radarr.enable = false;
    };
  };
}
