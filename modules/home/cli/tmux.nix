{
  config,
  hostConfig,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.cli.tmux;
in {
  options.cli.tmux = {enable = mkEnableOption "tmux";};

  config = mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      shortcut = "a";
      terminal = "xterm-256color";
      baseIndex = 1;
      keyMode = "vi"; # VI Mode
      customPaneNavigationAndResize = true; # Override hjkl and HJKL bindings for pane navigation and resizing VI Mode
      historyLimit = 10000;
      mouse = true;

      extraConfig = ''
        # Automatically set window titles
        set-window-option -g automatic-rename on
        set-option -g set-titles on

        # Enable 24-bit "True color" support
        set-option -ga terminal-overrides ",xterm-256color:Tc"
      '';

      plugins = with pkgs; [
        {
          plugin = tmuxPlugins.catppuccin;
          extraConfig = ''
            set -g @catppuccin-flavor "mocha"
            set -g @catppuccin_icon_window_last "󰖰 "
            set -g @catppuccin_icon_window_current "󰖯 "
            set -g @catppuccin_icon_window_zoom "󰁌 "
            set -g @catppuccin_icon_window_mark "󰃀 "
            set -g @catppuccin_icon_window_silent "󰂛 "
            set -g @catppuccin_icon_window_activity "󱅫 "
            set -g @catppuccin_icon_window_bell "󰂞 "
          '';
        }
      ];
    };

    home.persistence."/persist/home" = mkIf hostConfig.system.impermanence.enable {
      directories = [
        ".config/tmux"
      ];
    };
  };
}
