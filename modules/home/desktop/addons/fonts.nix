{ lib, config, pkgs, ... }:
with lib;
let
  cfg = config.modules.desktop.addons.fonts;
in
{
  options.modules.desktop.addons.fonts = { enable = mkEnableOption "fonts"; };

  config = mkIf cfg.enable {
    fonts.fontconfig.enable = true;

    home.packages = [
      (pkgs.nerdfonts.override { fonts = [ "FiraMono" "DroidSansMono" ]; })
    ];
  };
}
