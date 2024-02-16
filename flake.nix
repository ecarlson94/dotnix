{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";

    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.inputs.home-manager.follows = "home-manager";
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
          wsl = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
              ./machines/wsl/configuration.nix
              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.nixos = import ./machines/wsl/home.nix;

                # Optionally, use home-manager.extraSpecialArgs to pass
                # arguments to home.nix
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
          checks =
            let
              nvim = self.packages.${system}.nvim;
            in
            {
              nixpkgs-fmt = pkgs.callPackage ./checks/nixpkgs-fmt.nix { inherit inputs; };
              nvim = pkgs.callPackage ./checks/nvim.nix { inherit nixvim nvim system; };
            };

          packages = {
            nvim = pkgs.callPackage ./modules/nvim/makeNvim.nix { inherit inputs system nixvim; };
          };
        };
    };
}
