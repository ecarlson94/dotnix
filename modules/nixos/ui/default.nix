{
  pkgs,
  inputs,
  lib,
  config,
  theme,
  ...
}:
with lib; let
  cfg = config.ui;
in {
  imports = [
    inputs.catppuccin.nixosModules.catppuccin

    ./bluetooth.nix
    ./bootloader.nix
    ./file-manager.nix
    ./gaming.nix
    ./hyprland.nix
    ./plymouth.nix
    ./sddm-theme.nix
    ./sound.nix
  ];

  options.ui = {enable = mkEnableOption "ui";};

  config = mkIf cfg.enable {
    catppuccin.flavor = theme.variant;

    environment.systemPackages = with pkgs; [
      gnome-calculator
      loupe # Image Viewer
      zoom-us # Conferencing Software
    ];

    ui = {
      bluetooth.enable = true;
      fileManager.enable = true;
      hyprland.enable = true; # Tiling Manager
      plymouth.enable = true; # Boot Splash Screen
      sddmTheme.enable = true; # SDDM Display Manager Theme
      sound.enable = true;
    };
  };
}
