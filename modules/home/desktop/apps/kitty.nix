{ lib, config, theme, ... }:
with lib;
let
  cfg = config.modules.desktop.kitty;
in
{
  options.modules.desktop.kitty = { enable = mkEnableOption "kitty"; };

  config = mkIf cfg.enable {
    programs.kitty = {
      enable = true;
      shellIntegration.enableZshIntegration = true;
      theme = "Catppuccin-Mocha";

      font = {
        name = "Fira Code";
        size = 12;
      };

      settings = {
        copy_on_select = "clipboard";
        term = "xterm-256color";

        background_opacity = ".75";
      };
    };

    wayland.windowManager.hyprland.settings = {
      bind = [
        "CONTROLSHIFTALT,T,exec,kitty"
      ];
    };
  };
}
