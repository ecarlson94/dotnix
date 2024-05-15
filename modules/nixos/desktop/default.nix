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
    ./hyprland
    ./packages.nix
    ./plymouth.nix
    ./sound.nix
  ];

  catppuccin.flavour = theme.variant;
}
