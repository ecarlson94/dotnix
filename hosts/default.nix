{ nixpkgs, self, ... }:
let
  inherit (self) inputs packages;

  desktop = ../modules/system/desktop;

  createHomeManager = { system, user, homeFile }: {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${user} = import homeFile;

    # Optionally, use home-manager.extraSpecialArgs to pass
    # arguments to home.nix
    extraSpecialArgs = {
      inherit (packages.${system}) nvim;
      firefox-addons = inputs.firefox-addons.packages.${system};
      theme = import ../theme;
    };
  };
in
{
  nixos-wsl = nixpkgs.lib.nixosSystem rec {
    system = "x86_64-linux";
    modules = [
      ./nixos-wsl/configuration.nix
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager = createHomeManager {
          inherit system;
          user = "walawren";
          homeFile = ./nixos-wsl/home.nix;
        };
      }
    ];
    specialArgs = { inherit inputs; };
  };

  desktop = nixpkgs.lib.nixosSystem rec {
    system = "x86_64-linux";
    modules = [
      ./desktop/configuration.nix
      desktop
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager = createHomeManager {
          inherit system;
          user = "walawren";
          homeFile = ./desktop/home.nix;
        };
      }
    ];
    specialArgs = { inherit inputs; };
  };
}
