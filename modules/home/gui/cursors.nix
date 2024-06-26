{
  lib,
  config,
  pkgs,
  theme,
  ...
}:
with lib; let
  cfg = config.modules.gui.cursors;
in {
  options.modules.gui.cursors = {enable = mkEnableOption "cursors";};

  config = mkIf cfg.enable {
    home.pointerCursor = {
      gtk.enable = true;
      x11.enable = true;

      name = "catppuccin-${theme.variant}-teal-cursors";
      package = pkgs.catppuccin-cursors."${theme.variant}Teal";
      size = 24;
    };
  };
}
