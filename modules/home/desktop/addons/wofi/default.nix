{ lib, config, ... }:
with lib;
let
  cfg = config.modules.desktop.addons.wofi;
in
{
  options.modules.desktop.addons.wofi = { enable = mkEnableOption "wofi"; };

  config = mkIf cfg.enable {
    programs.wofi = {
      enable = true;
    };

    wayland.windowManager.hyprland.settings = {
      bind = [
        "CONTROLSHIFTALT,A,exec,wofi --show drun"
      ];
    };
  };
}
