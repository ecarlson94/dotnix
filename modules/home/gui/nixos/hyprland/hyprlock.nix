{
  lib,
  config,
  theme,
  ...
}:
with theme.colors;
with lib; let
  cfg = config.modules.gui.nixos.hyprland.hyprlock;
in {
  options.modules.gui.nixos.hyprland.hyprlock = {enable = mkEnableOption "hyprlock";};

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

            outer_color = "rgb(${primaryAccent})";
            inner_color = "rgb(${base})";
            font_color = "rgb(${text})";
            fail_color = "rgb(${red})";
            rounding = theme.radius;

            fade_on_empty = false;
            placeholder_text = ''<span font_family="${theme.font}" foreground="##${subtext1}">Password...</span>'';

            dots_spacing = 0.3;
            dots_center = true;
          }
        ];

        label = [
          {
            monitor = "";
            text = "$TIME";
            font_family = theme.font;
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
        "SUPERCONTROLSHIFTALT,N,exec,hyprlock"
      ];
    };
  };
}
