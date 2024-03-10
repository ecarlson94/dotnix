{ lib, config, pkgs, theme, ... }:
with lib;
let
  cfg = config.modules.desktop.hyprland;
  meh = "CONTROLSHIFTALT";
  hyper = "SUPERCONTROLSHIFTALT";

  # binds $meh + [SUPER +] {1...8} to [move to] workspace {1...8} (stolen from sioodmy)
  workspaces = builtins.concatLists (builtins.genList
    (
      i:
      let
        workspace = builtins.toString (i + 1);
      in
      [
        "${meh}, ${workspace}, workspace, ${workspace}"
        "${hyper}, ${workspace}, movetoworkspace, ${workspace}"
      ]
    )
    8
  );

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
          "${meh},F, fullscreen"

          "${meh},H,movefocus,l"
          "${meh},L,movefocus,r"
          "${meh},K,movefocus,u"
          "${meh},J,movefocus,d"

          "${hyper},H,movewindow,l"
          "${hyper},L,movewindow,r"
          "${hyper},K,movewindow,u"
          "${hyper},J,movewindow,d"
        ]
        ++ workspaces;

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
