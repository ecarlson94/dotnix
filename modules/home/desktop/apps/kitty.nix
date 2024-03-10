{ lib, config, ... }:
with lib;
let
  cfg = config.modules.desktop.kitty;
in
{
  options.modules.desktop.kitty = { enable = mkEnableOption "kitty"; };

  config = mkIf cfg.enable {
    modules.desktop.fonts.enable = true;

    programs.kitty = {
      enable = true;
      shellIntegration.enableZshIntegration = true;
      theme = "Catppuccin-Mocha";

      font = {
        name = "Fira Code";
        size = 14;
      };

      settings = {
        confirm_os_window_close = "0";
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
