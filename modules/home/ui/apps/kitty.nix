{
  lib,
  config,
  theme,
  ...
}:
with lib; let
  cfg = config.modules.ui.apps.kitty;
in {
  options.modules.ui.apps.kitty = {enable = mkEnableOption "kitty";};

  config = mkIf cfg.enable {
    modules.ui.fonts.enable = true;

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

        background_opacity = ".85";
      };
    };

    wayland.windowManager.hyprland.settings = {
      bind = [
        "CONTROLSHIFTALT,T,exec,kitty"
      ];
    };
  };
}
