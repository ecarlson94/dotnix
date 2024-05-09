{inputs, ...}: {
  imports = [
    inputs.catppuccin.nixosModules.catppuccin

    ./bootloader.nix
    ./file-explorer.nix
    ./gaming.nix
    ./hyprland.nix
    ./packages.nix
    ./plymouth.nix
    ./sound.nix
  ];
}
