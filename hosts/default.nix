{ nixpkgs, self, ... }:
let
  inherit (self) inputs packages;
in
{
  nixos-wsl = nixpkgs.lib.nixosSystem rec {
    system = "x86_64-linux";
    modules = [
      ./nixos-wsl/configuration.nix
      ../modules/nixos/user.nix
      ../modules/nixos/home.nix
    ];
    specialArgs = {
      inherit inputs system packages;
      target = "nixos-wsl";
      homeOptions = { modules.cli.enable = true; };
    };
  };

  desktop = nixpkgs.lib.nixosSystem rec {
    system = "x86_64-linux";
    modules = [
      ./desktop/configuration.nix
      ../modules/nixos/desktop
      ../modules/nixos/user.nix
      ../modules/nixos/home.nix
    ];
    specialArgs = {
      inherit inputs system packages;
      target = "desktop";
      homeOptions = { modules.desktop.enable = true; };
    };
  };
}
