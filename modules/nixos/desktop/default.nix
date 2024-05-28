{
  inputs,
  theme,
  ...
}: {
  imports = [
    inputs.catppuccin.nixosModules.catppuccin

    ./bluetooth.nix
    ./bootloader.nix
    ./file-manager.nix
    ./gaming.nix
    ./hyprland.nix
    ./packages.nix
    ./plymouth.nix
    ./sddm-theme.nix
    ./sound.nix
  ];

  catppuccin.flavor = theme.variant;
}
