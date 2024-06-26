{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.gui.nixos;
in {
  imports = [
    ./hyprland
    ./waybar

    ./fuzzel.nix
    ./gtk.nix
  ];

  options.modules.gui.nixos = {enable = mkEnableOption "nixos";};

  config = mkIf cfg.enable {
    modules.gui.nixos = {
      fuzzel.enable = true; # Application launcher
      grimblast.enable = true; # Screenshot utility
      hypridle.enable = true; # Idle daemon
      hyprland.enable = true; # Tiling Wayland Compositor
      hyprlock.enable = true; # Lock screen
      hyprpaper.enable = true; # Configures wallpaper
      waybar.enable = true; # Desktop Bar
    };
  };
}
