{ lib, config, ... }:
with lib;
let
  cfg = config.modules.desktop;
in
{
  imports = [
    ../cli
    ./apps
    ./addons
  ];

  options.modules.desktop = { enable = mkEnableOption "desktop"; };

  config = mkIf cfg.enable {
    programs.dircolors.enable = true;
    modules = {
      cli.enable = true;

      desktop = {
        hyprland.enable = true; # Tiling Wayland Compositor
        kitty.enable = true; # Terminal Emulator
      };
    };
  };
}
