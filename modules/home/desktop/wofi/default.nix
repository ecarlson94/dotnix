{ lib, config, pkgs, theme, ... }:
with lib;
let
  cfg = config.modules.desktop.wofi;
in
{
  options.modules.desktop.wofi = { enable = mkEnableOption "wofi"; };

  config = mkIf cfg.enable {
    programs.wofi = {
      enable = true;
    };

    wayland.windowManager.hyprland.settings = {
      bind = [
        "SUPER,SPACE,exec,wofi --show drun"
      ];
    };
  };
}
