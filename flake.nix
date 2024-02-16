{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";

    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:ecarlson94/nixvim/569efbbe645317a08708234cb059f57ac1712ea5";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    { flake-parts
    , nixpkgs
    , home-manager
    , ...
    } @ inputs:
    let
      # config = import ./config; # import the nixvim module directly
    in
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
        let
          # nixvimLib = nixvim.lib.${system};
          # nixvim' = nixvim.legacyPackages.${system};
          # nvim = nixvim'.makeNixvimWithModule {
          #   inherit pkgs;
          #   module = config;
          #   # You can use `extraSpecialArgs` to pass additional arguments to your module files
          #   extraSpecialArgs = {
          #     # inherit (inputs) foo;
          #   };
          # };
        in
        {
          checks =
            let
              args = { inherit inputs; };
            in
            {
              nixpkgs-fmt = pkgs.callPackage ./checks/nixpkgs-fmt.nix args;
            };
        };
    };
}
