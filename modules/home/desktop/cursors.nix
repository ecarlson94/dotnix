{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.desktop.cursors;
in {
  options.modules.desktop.cursors = {enable = mkEnableOption "cursors";};

  config = mkIf cfg.enable {
    home.pointerCursor = {
      gtk.enable = true;
      x11.enable = true;

      name = "Catppuccin-Mocha-Teal-Cursors";
      package = pkgs.catppuccin-cursors.mochaTeal;
      size = 18;
    };
  };
}
