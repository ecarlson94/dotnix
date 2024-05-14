{
  pkgs,
  inputs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.desktop.nixos.grimblast;
in {
  options.modules.desktop.nixos.grimblast = {enable = mkEnableOption "grimblast";};

  config = mkIf cfg.enable {
    home.packages = [
      inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
    ];

    wayland.windowManager.hyprland.settings = {
      bind = [
        "CONTROLSHIFTALT,O,exec,grimblast copy area"
        "CONTROLSHIFTALT,E,exec,grimblast edit area"
      ];
    };
  };
}
