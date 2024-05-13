{
  lib,
  config,
  pkgs,
  theme,
  ...
}:
with lib; let
  cfg = config.modules.desktop.apps.kitty;
in {
  options.modules.desktop.apps.kitty = {enable = mkEnableOption "kitty";};

  config = mkIf cfg.enable {
    modules.desktop.fonts.enable = true;

    home.packages = with pkgs; [
      wl-clipboard
    ];

    programs.kitty = {
      enable = true;
      theme = "Catppuccin-${theme.variantUpper}";

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
