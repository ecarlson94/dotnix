{ lib, config, theme, inputs, ... }:
with lib;
let
  cfg = config.modules.desktop.nixos.hyprlock;

  base = theme.stripPound theme.colors.base;
  accent = theme.stripPound theme.colors.primaryAccent;
  text = theme.stripPound theme.colors.text;
  subtext1 = theme.stripPound theme.colors.subtext1;
  lavender = theme.stripPound theme.colors.lavender;
  red = theme.stripPound theme.colors.red;
  font_family = "Fira Code";
in
{
  imports = [
    inputs.hyprlock.homeManagerModules.hyprlock
  ];

  options.modules.desktop.nixos.hyprlock = { enable = mkEnableOption "hyprlock"; };

  config = mkIf cfg.enable {
    programs.hyprlock = {
      enable = true;

      general = {
        disable_loading_bar = true;
        hide_cursor = false;
        no_fade_in = true;
      };

      backgrounds = [
        {
          monitor = "";
          path = "${theme.defaultWallpaper}";
        }
      ];

      input-fields = [
        {
          monitor = "";

          size = {
            width = 300;
            height = 50;
          };

          outline_thickness = 2;

          outer_color = "rgb(${accent})";
          inner_color = "rgb(${base})";
          font_color = "rgb(${text})";
          fail_color = "rgb(${red})";
          rounding = theme.radius;

          fade_on_empty = false;
          placeholder_text = ''<span font_family="${font_family}" foreground="##${subtext1}">Password...</span>'';

          dots_spacing = 0.3;
          dots_center = true;
        }
      ];

      labels = [
        {
          monitor = "";
          text = "$TIME";
          inherit font_family;
          font_size = 64;
          color = "rgb(${lavender})";

          position = {
            x = 0;
            y = 80;
          };

          valign = "center";
          halign = "center";
        }
      ];
    };

    wayland.windowManager.hyprland.settings = {
      bind = [
        "SUPERCONTROLSHIFTALT,L,exec,hyprlock"
      ];
    };
  };
}
