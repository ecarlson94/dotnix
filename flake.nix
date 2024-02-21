{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs =
    { flake-parts
    , nixpkgs
    , home-manager
    , nixvim
    , self
    , ...
    } @ inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      flake = {
        nixosConfigurations = {
          nixos-wsl = nixpkgs.lib.nixosSystem rec {
            system = "x86_64-linux";
            modules = [
              ./hosts/nixos-wsl/configuration.nix
              home-manager.nixosModules.home-manager
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  users.nixos = import ./hosts/nixos-wsl/home.nix;

                  # Optionally, use home-manager.extraSpecialArgs to pass
                  # arguments to home.nix
                  extraSpecialArgs = {
                    inherit (self.packages.${system}) nvim;
                  };
                };
              }
            ];
            specialArgs = { inherit inputs; };
          };
        };
      };

      perSystem =
        { pkgs
        , system
        , ...
        }:
        {
          formatter = pkgs.nixpkgs-fmt;

          checks = {
            nixpkgs-fmt = pkgs.callPackage ./checks/nixpkgs-fmt.nix { inherit inputs; };
            statix = pkgs.callPackage ./checks/statix.nix { inherit inputs; };
            nvim = pkgs.callPackage ./checks/nvim.nix {
              inherit nixvim system;
              inherit (self.packages.${system}) nvim;
            };
          };

          packages = {
            nvim = pkgs.callPackage ./modules/nvim/makeNvim.nix { inherit inputs system nixvim; };
          };
        };
    };
}
