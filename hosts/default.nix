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
      ../modules/nixos
    ];
    specialArgs = {
      inherit inputs system packages;
      homeOptions.cli = {
        enable = true;
        wsl.enable = true;
      };
    };
  };

  nixos-desktop = nixpkgs.lib.nixosSystem rec {
    system = "x86_64-linux";
    modules = [
      ./nixos-desktop/configuration.nix
      ../modules/nixos
      {
        ui = {
          enable = true;
          gaming.enable = true;
        };
      }
    ];
    specialArgs = {
      inherit inputs system packages;
      theme = import ../theme;
      homeOptions.ui = {
        enable = true;
        nixos.enable = true;
      };
    };
  };
}
