{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.desktop.nixos;
in {
  imports = [
    ./hyprland
    ./waybar

    ./gtk.nix
    ./wofi.nix
  ];

  options.modules.desktop.nixos = {enable = mkEnableOption "nixos";};

  config = mkIf cfg.enable {
    modules = {
      desktop = {
        nixos = {
          hypridle.enable = true; # Idle daemon
          hyprland.enable = true; # Tiling Wayland Compositor
          hyprlock.enable = false; # Lock screen
          hyprpaper.enable = true; # Configures wallpaper
          wofi.enable = true; # Application launcher
          waybar.enable = true; # Desktop Bar
        };
      };
    };
  };
}
