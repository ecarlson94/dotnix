{ lib, config, ... }:
with lib;
let
  cfg = config.modules.desktop.nixos;
in
{
  imports = [
    ./hyprland
    ./waybar

    ./gtk.nix
    ./wallpaper.nix
    ./wofi.nix
  ];

  options.modules.desktop.nixos = { enable = mkEnableOption "nixos"; };

  config = mkIf cfg.enable {
    modules = {
      desktop = {
        nixos = {
          hyprland.enable = true; # Tiling Wayland Compositor
          hyprlock.enable = true; # Lock screen
          hypridle.enable = true; # Idle daemon
          wallpaper.enable = true; # Configures the wallpaper
          wofi.enable = true; # Application launcher
          waybar.enable = true; # Desktop Bar
        };
      };
    };
  };
}
