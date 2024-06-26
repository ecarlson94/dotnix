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
      hyprland.enable = true; # Tiling Wayland Compositor
      waybar.enable = true; # Desktop Bar
    };
  };
}
