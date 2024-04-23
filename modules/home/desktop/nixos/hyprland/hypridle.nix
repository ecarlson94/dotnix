{
  lib,
  config,
  inputs,
  ...
}:
with lib; let
  cfg = config.modules.desktop.nixos.hypridle;
in {
  imports = [
    inputs.hypridle.homeManagerModules.hypridle
  ];

  options.modules.desktop.nixos.hypridle = {enable = mkEnableOption "hypridle";};

  config = mkIf cfg.enable {
    services.hypridle = {
      enable = true;
      lockCmd = "pidof hyprlock || ${lib.getExe config.programs.hyprlock.package}"; # avoid starting multiple hyprlock instances
      beforeSleepCmd = "loginctl lock-session"; # Lock before suspend
      afterSleepCmd = "hyprctl dispatch dpms on"; # to avoid having to press a key twice to turn on the display

      listeners = [
        {
          timeout = 300; # 5 minutes
          onTimeout = "loginctl lock-session"; # lock screen when timeout has passed
        }
        # {
        #   timeout = 600; # 10 minutes
        #   onTimeout = "hyprctl dispatch dpms off"; # screen off after timeout
        #   onResume = "hyprctl dispatch dpms on"; # screen on when activity is detected after timeout has fired
        # }
      ];
    };
  };
}
