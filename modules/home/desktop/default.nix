{ lib, config, ... }:
with lib;
let
  cfg = config.modules.desktop;
in
{
  imports = [
    ../cli

    ./apps
    ./hyprland
    ./waybar

    ./gtk.nix
    ./fonts.nix
    ./wallpaper.nix
    ./wofi.nix
  ];

  options.modules.desktop = { enable = mkEnableOption "desktop"; };

  config = mkIf cfg.enable {
    programs.dircolors.enable = true;
    modules = {
      cli.enable = true;

      desktop = {
        hyprland.enable = true; # Tiling Wayland Compositor
        wallpaper.enable = true; # Configures the wallpaper
        wofi.enable = true; # Application launcher
        waybar.enable = true; # Desktop Bar

        apps = {
          kitty.enable = true; # Terminal Emulator
          firefox.enable = true; # Browser
        };
      };
    };
  };
}
