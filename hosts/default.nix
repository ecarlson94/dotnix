{ nixpkgs, self, ... }:
let
  inherit (self) inputs packages;

  userHomeModules = [
    ../modules/nixos/user.nix
    ../modules/nixos/home.nix
  ];
in
{
  nixos-wsl = nixpkgs.lib.nixosSystem rec {
    system = "x86_64-linux";
    modules = [
      ./nixos-wsl/configuration.nix
    ] ++ userHomeModules;
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
    ] ++ userHomeModules;
    specialArgs = {
      inherit inputs system packages;
      target = "desktop";
      homeOptions = { modules.desktop.enable = true; };
    };
  };
}
