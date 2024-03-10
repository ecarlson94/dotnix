{ lib, config, pkgs, ... }:
with lib;
let
  cfg = config.modules.desktop.fonts;
in
{
  options.modules.desktop.fonts = { enable = mkEnableOption "fonts"; };

  config = mkIf cfg.enable {
    fonts.fontconfig.enable = true;

    home.packages = [
      (pkgs.nerdfonts.override { fonts = [ "FiraMono" "DroidSansMono" ]; })
    ];
  };
}
