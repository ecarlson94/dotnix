{
  description = "NixOS configuration";

  inputs = {
    # Repo configuration dependencies
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # User configuration dependencies
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    # UI deps
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix";

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    firefox-addons,
    self,
    ...
  } @ inputs: let
    lib = nixpkgs.lib // home-manager.lib;
    systems = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];

    forEachSystem = f:
      lib.genAttrs systems (system:
        f {
          inherit system;
          pkgs = pkgsFor.${system};
        });

    pkgsFor = lib.genAttrs systems (
      system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          config.allowUnfreePredicate = _: true;
        }
    );
  in {
    inherit lib;

    formatter = forEachSystem ({pkgs, ...}: pkgs.alejandra);

    checks = forEachSystem ({pkgs, ...}: {
      format = pkgs.callPackage ./checks/format.nix {inherit inputs;};
      statix = pkgs.callPackage ./checks/statix.nix {inherit inputs;};
    });

    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home;

    nixosConfigurations = import ./hosts inputs;

    devShells = forEachSystem ({pkgs, ...}: {
      default = pkgs.mkShell {
        packages = with pkgs; [
          alejandra
          prettierd
          cachix
        ];
      };
    });
  };
}
