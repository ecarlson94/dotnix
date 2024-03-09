{ lib, config, pkgs, theme, ... }:
with lib;
let
  cfg = config.modules.desktop.tofi;
in
{
  options.modules.desktop.tofi = { enable = mkEnableOption "tofi"; };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.tofi ];

    wayland.windowManager.hyprland.settings = {
      bind = [
        "SUPER,SPACE,exec,run-as-service $(tofi-drun)"
      ];
    };

    xdg.configFile."tofi/config".text = with theme.colors; ''
      anchor = center
      width = 500
      height = 300
      horizontal = false
      font-size = 14
      prompt-text = "Run "

      font = monospace
      ascii-input = false
      outline-width = 5
      outline-color = ${surface0}

      border-width = 2
      border-color = ${accent}
      background-color = ${base}
      text-color = ${text}
      selection-color = ${accent}

      min-input-width = 120
      late-keyboard-init = true
      result-spacing = 10
      padding-top = 15
      padding-bottom = 15
      padding-left = 15
      padding-right = 15
    '';
  };
}
