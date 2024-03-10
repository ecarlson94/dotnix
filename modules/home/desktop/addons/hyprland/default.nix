{ lib, config, pkgs, theme, ... }:
with lib;
let
  cfg = config.modules.desktop.hyprland;
  meh = "CONTROLSHIFTALT";
  hyper = "SUPERCONTROLSHIFTALT";

  mkService = lib.recursiveUpdate {
    Unit.PartOf = [ "graphical-session.target" ];
    Unit.After = [ "graphical-session.target" ];
    Install.WantedBy = [ "graphical-session.target" ];
  };
in
{
  options.modules.desktop.hyprland = { enable = mkEnableOption "hyprland"; };

  config = mkIf cfg.enable {
    modules.desktop.addons = {
      wofi.enable = true;
    };

    home.packages = with pkgs; [
      wf-recorder
      wl-clipboard
    ];

    wayland.windowManager.hyprland = {
      enable = true;

      settings = {
        bind = [
          "${meh},Q,killactive"

          "${meh},H,movefocus,l"
          "${meh},L,movefocus,r"
          "${meh},K,movefocus,u"
          "${meh},J,movefocus,d"

          "${hyper},H,movewindow,l"
          "${hyper},L,movewindow,r"
          "${hyper},K,movewindow,u"
          "${hyper},J,movewindow,d"
        ];

        bindm = [
          "${meh},mouse:272,movewindow" # TODO: remove after reflashing keyboard
        ];
      };
    };

    systemd.user.services = {
      swaybg = mkService {
        Unit.Description = "Wallpaper chooser";
        Service = {
          ExecStart = "${lib.getExe pkgs.swaybg} -i ${theme.defaultWallpaper}";
        };
      };
    };
  };
}
