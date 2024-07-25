{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.ui.nixos;
in {
  imports = [
    ./fuzzel.nix
    ./gtk.nix
    ./hyprland
    ./mako.nix
    ./waybar
  ];

  options.modules.ui.nixos = {enable = mkEnableOption "nixos";};

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      wf-recorder
      wl-clipboard
    ];

    modules.ui.nixos = {
      fuzzel.enable = true; # Application launcher
      hyprland.enable = true; # Wayland Compositor (Tiling)
      mako.enable = true; # Notification daemon
      waybar.enable = true; # Desktop Bar
    };
  };
}
