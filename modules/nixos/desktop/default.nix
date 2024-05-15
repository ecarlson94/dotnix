{
  inputs,
  theme,
  ...
}: {
  imports = [
    inputs.catppuccin.nixosModules.catppuccin

    ./bootloader.nix
    ./file-explorer.nix
    ./gaming.nix
    ./hyprland.nix
    ./packages.nix
    ./plymouth.nix
    ./sddm-theme.nix
    ./sound.nix
  ];

  catppuccin.flavour = theme.variant;
}
