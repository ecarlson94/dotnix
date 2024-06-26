{
  pkgs,
  inputs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.gui.nixos.grimblast;
in {
  options.modules.gui.nixos.grimblast = {enable = mkEnableOption "grimblast";};

  config = mkIf cfg.enable {
    home.packages = [
      inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
    ];

    home.sessionVariables = {
      GRIMBLAST_EDITOR = "${pkgs.pinta}/bin/pinta";
    };

    wayland.windowManager.hyprland.settings = {
      bind = [
        "CONTROLSHIFTALT,O,exec,grimblast copy area"
        "CONTROLSHIFTALT,E,exec,grimblast edit area"
      ];
    };
  };
}
