{ lib, config, theme, ... }:
with lib;
let
  cfg = config.modules.desktop.waybar;
in
{
  options.modules.desktop.waybar = { enable = mkEnableOption "waybar"; };

  config = mkIf cfg.enable {
    modules.desktop.fonts.enable = true;

    programs.waybar = {
      enable = true;

      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          mod = "dock";
          height = 48;

          modules-left = [ "hyprland/workspaces" ];

          modules-right = [
            "tray"
            "network"
            "pulseaudio"
            "memory"
            "cpu"
            "battery"
            "clock"
          ];

          "hyprland/workspaces" = {
            active-only = false;
            all-outputs = true;
            disable-scroll = false;
            on-scroll-up = "hyprctl dispatch workspace e-1";
            on-scroll-down = "hyprctl dispatch workspace e+1";
            on-click = "activate";
            format = "{icon}";
            format-icons = {
              sort-by-number = true;
            };
          };

          tray = {
            icon-size = 15;
            spacing = 8;
          };

          network = {
            format-wifi = "  {essid} {signalStrength}%";
            format-ethernet = "󰈀";
            format-disconnected = "󰈂";
          };

          pulseaudio = {
            format = "{icon} {volume}%";
            format-muted = "󰝟";
            format-icons = {
              default = [ "󰕿" "󰖀" "󰕾" ];
            };
            scroll-step = 5;
            on-click = "pavucontrol";
          };

          memory = {
            format = "󰍛 {percentage}%";
            format-alt = "󰍛 {used}/{total} GiB";
            interval = 5;
          };

          cpu = {
            format = "󰻠 {usage}%";
            format-alt = "󰻠 {avg_frequency} GHz";
            interval = 5;
          };

          battery = {
            states = {
              good = 95;
              warning = 30;
              critical = 15;
            };
            format = "{icon}  {capacity}%";
            format-charging = "  {capacity}%";
            format-plugged = " {capacity}% ";
            format-alt = "{icon} {time}";
            format-icons = [ "" "" "" "" "" ];
          };

          clock = {
            format = "󰥔  {:%a, %d %b, %I:%M %p}";
            tooltip = "true";
            tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
            format-alt = "   {:%d/%m}";
          };
        };
      };

      style = import ./style.nix { inherit theme; };
    };
  };
}
