{
  nixpkgs,
  self,
  ...
}: let
  inherit (self) inputs packages;
in {
  nixos-wsl = nixpkgs.lib.nixosSystem rec {
    system = "x86_64-linux";
    modules = [
      ./nixos-wsl/configuration.nix
      ../modules/nixos/system
      ../modules/user
      ../modules/nixos/home.nix
    ];
    specialArgs = {
      inherit inputs system packages;
      homeOptions.modules.cli = {
        enable = true;
        wsl.enable = true;
      };
    };
  };

  nixos-desktop = nixpkgs.lib.nixosSystem rec {
    system = "x86_64-linux";
    modules = [
      ./nixos-desktop/configuration.nix
      ../modules/nixos/system
      ../modules/nixos/gui
      ../modules/user
      ../modules/nixos/home.nix
    ];
    specialArgs = {
      inherit inputs system packages;
      theme = import ../theme;
      homeOptions.modules.gui = {
        enable = true;
        nixos.enable = true;
      };
    };
  };
}
