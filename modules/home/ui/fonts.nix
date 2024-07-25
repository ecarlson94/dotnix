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
      (pkgs.nerdfonts.override {fonts = ["FiraMono" "DroidSansMono"];})
    ];
  };
}
