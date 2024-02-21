{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.modules.tmux;
in
{
  imports = [ ../dircolors ];

  options.modules.tmux = { enable = mkEnableOption "tmux"; };

  config = mkIf cfg.enable {
    modules.dircolors.enable = true;

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

        # Setup right status bar
        set -g status-right-length "60"
        set -g status-right "#{prefix_highlight}#[fg=brightblack,bg=black,nobold,noitalics,nounderscore]#[fg=white,bg=brightblack] #{battery_icon}#{battery_percentage}  #{cpu_icon} #{cpu_percentage} #[fg=white,bg=brightblack,nobold,noitalics,nounderscore]#[fg=white,bg=brightblack] %H:%M #[fg=cyan,bg=brightblack,nobold,noitalics,nounderscore]#[fg=black,bg=cyan,bold] #H "
      '';

      plugins = with pkgs; [
        {
          plugin = tmuxPlugins.catppuccin;
          extraConfig = ''
            set -g @catppuccin-flavor "mocha"
          '';
        }
      ];
    };
  };
}
