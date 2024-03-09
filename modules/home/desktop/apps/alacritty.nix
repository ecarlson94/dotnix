{ lib, config, theme, ... }:
with lib;
let
  cfg = config.modules.desktop.alacritty;
in
{
  options.modules.desktop.alacritty = { enable = mkEnableOption "alacritty"; };

  config = mkIf cfg.enable {
    programs.alacritty = {
      enable = true;

      settings = {
        font = {
          size = 12;
        };

        colors = with theme.colors; {
          primary = {
            background = base;
            foreground = text;
            dim_foreground = text;
            bright_foregrount = text;
          };

          cursor = {
            text = base;
            cursor = accent;
          };

          vi_mode_cusor = {
            text = base;
            cursor = accent2;
          };

          search = {
            matches = {
              foreground = base;
              background = subtext0;
            };

            focused_matched = {
              foreground = base;
              background = green;
            };

            footer_bar = {
              foreground = base;
              background = subtext0;
            };
          };

          hints = {
            start = {
              foreground = base;
              background = yellow;
            };

            end = {
              foreground = base;
              background = subtext0;
            };
          };

          selection = {
            text = base;
            background = rosewater;
          };

          bright = {
            inherit red green yellow blue;

            black = surface2;
            magenta = pink;
            cyan = teal;
            white = subtext0;
          };

          dim = {
            inherit red green yellow blue;

            black = surface1;
            magenta = pink;
            cyan = teal;
            white = surface1;
          };

          indexed_colors = [
            { index = 16; color = peach; }
            { index = 17; color = rosewater; }
          ];
        };

        keyboard.bindings = [
          { key = "Space"; mods = "Control"; action = "ToggleViMode"; }
        ];
      };
    };
  };
}
