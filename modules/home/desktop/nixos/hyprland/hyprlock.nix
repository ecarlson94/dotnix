{
  lib,
  config,
  theme,
  ...
}:
with lib; let
  cfg = config.modules.desktop.nixos.hyprlock;

  base = theme.stripPound theme.colors.base;
  accent = theme.stripPound theme.colors.primaryAccent;
  text = theme.stripPound theme.colors.text;
  subtext1 = theme.stripPound theme.colors.subtext1;
  lavender = theme.stripPound theme.colors.lavender;
  red = theme.stripPound theme.colors.red;
  font_family = "Fira Code";
in {
  options.modules.desktop.nixos.hyprlock = {enable = mkEnableOption "hyprlock";};

  config = mkIf cfg.enable {
    programs.hyprlock = {
      enable = true;

      settings = {
        general = {
          disable_loading_bar = true;
          hide_cursor = false;
          no_fade_in = true;
        };

        background = [
          {
            monitor = "";
            path = "${theme.defaultWallpaper}";
          }
        ];

        input-field = [
          {
            monitor = "";

            size = "300, 50";

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

        label = [
          {
            monitor = "";
            text = "$TIME";
            inherit font_family;
            font_size = 64;
            color = "rgb(${lavender})";

            position = "0, 80";

            valign = "center";
            halign = "center";
          }
        ];
      };
    };

    wayland.windowManager.hyprland.settings = {
      bind = [
        "SUPERCONTROLSHIFTALT,L,exec,hyprlock"
      ];
    };
  };
}
