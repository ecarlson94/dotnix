{ lib, config, theme, ... }:
with lib;
let
  cfg = config.modules.desktop.wofi;
  radius = "${builtins.toString theme.radius}px";
in
{
  options.modules.desktop.wofi = { enable = mkEnableOption "wofi"; };

  config = mkIf cfg.enable {
    modules.desktop.fonts.enable = true;

    programs.wofi = {
      enable = true;

      settings = {
        width = 900;
        height = 600;
        location = "center";
        show = "drun";
        prompt = "Search...";
        filter_rate = 100;
        allow_markup = true;
        no_actions = true;
        halign = "fill";
        orientation = "vertical";
        content_halign = "fill";
        insensitive = true;
        allow_images = true;
        image_size = 35;
        gtk_dark = true;
      };

      style = with theme.colors; ''
        window {
          margin: 5px;
          border: 5px solid ${base};
          border-radius: ${radius};
          font-family: "Fira Code";
          font-size: 14;
        }

        #input {
          all: unset;
          min-height: 36px;
          padding: 4px 10px;
          margin: 4px;
          border: none;
          color: ${text};
          font-weight: bold;
          background-color: ${mantle};
          outline: none;
          border-radius: ${radius};
          margin: 10px
          margin-bottom: 2px;
        }

        #inner-box {
          margin: 0px;
          padding: 10px;
          font-weight: bold;
          border-radius: ${radius};
        }

        #outer-box {
          margin: 0px;
          padding: 10px;
          border: none;
          border: 5px solid ${mantle};
          border-radius: ${radius};
        }

        #scroll {
          color: ${mantle};
          margin: 0px 0px;
          border: none;
          border-radius: ${radius};
        }

        #text:selected {
          color: ${mantle};
          margin: 0px 0px;
          border: none;
          border-radius: ${radius};
        }

        #entry {
          margin: 0px 0px;
          border: none;
          border-radius: ${radius};
          background-color: transparent;
        }

        #entry:selected {
          margin: 0px 0px;
          color: ${text}
          border: none;
          border-radius: ${radius};
          background-color: ${primaryAccent};
          background-size: 400% 400%;
        }
      '';
    };

    wayland.windowManager.hyprland.settings = {
      bind = [
        "CONTROLSHIFTALT,A,exec,wofi --show drun"
      ];
    };
  };
}
