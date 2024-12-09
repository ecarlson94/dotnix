{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.ui.fonts;
in {
  options.ui.fonts = {enable = mkEnableOption "fonts";};

  config = mkIf cfg.enable {
    fonts.fontconfig.enable = true;

    home.packages = [
      pkgs.nerd-fonts.fira_mono
      pkgs.nerd-fonts.droid_sans_mono
    ];
  };
}
