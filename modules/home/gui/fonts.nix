{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.gui.fonts;
in {
  options.modules.gui.fonts = {enable = mkEnableOption "fonts";};

  config = mkIf cfg.enable {
    fonts.fontconfig.enable = true;

    home.packages = [
      (pkgs.nerdfonts.override {fonts = ["FiraMono" "DroidSansMono"];})
    ];
  };
}
