{ lib, config, pkgs, theme, ... }:
with lib;
let
  cfg = config.modules.desktop.hyprland;
  meh = "CONTROLSHIFTALT";
  hyper = "SUPERCONTROLSHIFTALT";

  rgba = color: "rgba(${theme.stripPound color}ee)";
  primaryAccent = rgba theme.colors.primaryAccent;
  secondaryAccent = rgba theme.colors.secondaryAccent;
  tertiaryAccent = rgba theme.colors.tertiaryAccent;
  crust = rgba theme.colors.crust;

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
in
{
  options.modules.desktop.hyprland = { enable = mkEnableOption "hyprland"; };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      wf-recorder
      wl-clipboard
    ];

    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = true;

      settings = {
        general = {
          gaps_in = 2;
          gaps_out = 10;
          border_size = 3;
          layout = "dwindle";
          apply_sens_to_raw = 1; # whether to apply the sensitivity to raw input (e.g. used by games where you aim using your mouse)
          "col.active_border" = "${primaryAccent} ${secondaryAccent} ${tertiaryAccent} 45deg";
          "col.inactive_border" = "${crust}";
        };

        misc = {
          mouse_move_enables_dpms = true;
          key_press_enables_dpms = true;
        };

        decoration = {
          rounding = theme.radius;
          drop_shadow = "yes";
          shadow_range = 4;
          shadow_render_power = 3;
        };

        animations = {
          enabled = true;
          bezier = [
            "linear,0.0,0.0,1.0,1.0"
          ];
          animation = [
            "borderangle,1,100,linear,loop"
          ];
        };

        dwindle = {
          preserve_split = "yes";
        };

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
          "${meh},mouse:272,movewindow"
          "${meh},mouse:273,resizewindow"
        ];

        binde = [
          ",XF86AudioRaiseVolume,exec,pactl set-sink-volume @DEFAULT_SINK@ +5%"
          ",XF86AudioLowerVolume,exec,pactl set-sink-volume @DEFAULT_SINK@ -5%"
        ];
      };
    };
  };
}
