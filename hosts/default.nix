{ nixpkgs, self, ... }:
let
  inherit (self) inputs packages;

  userHomeModules = [
    ../modules/user
    inputs.home-manager.nixosModules.home-manager
    ../modules/system/home.nix
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
      ../modules/system/desktop
    ] ++ userHomeModules;
    specialArgs = {
      inherit inputs system packages;
      target = "desktop";
      homeOptions = { modules.desktop.enable = true; };
    };
  };
}
