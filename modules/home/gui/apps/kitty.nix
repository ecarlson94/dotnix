{
  lib,
  config,
  pkgs,
  theme,
  ...
}:
with lib; let
  cfg = config.modules.gui.apps.kitty;
in {
  options.modules.gui.apps.kitty = {enable = mkEnableOption "kitty";};

  config = mkIf cfg.enable {
    modules.gui.fonts.enable = true;

    home.packages = with pkgs; [
      wl-clipboard
    ];

    programs.kitty = {
      enable = true;
      theme = "Catppuccin-${theme.variantUpper}";

      font = {
        name = theme.font;
        size = theme.fontSize;
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
