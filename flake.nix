{
  description = "NixOS configuration";

  inputs = {
    # Repo configuration dependencies
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";

    git-hooks = {
      # Automatically runs check on commit
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
      url = "github:the-argus/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    flake-parts,
    nixpkgs,
    home-manager,
    nixvim,
    self,
    ...
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        inputs.git-hooks.flakeModule
      ];

      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      flake = {
        nixosConfigurations = import ./hosts inputs;
      };

      perSystem = {
        config,
        pkgs,
        system,
        ...
      }: {
        formatter = pkgs.alejandra;

        checks = {
          format = pkgs.callPackage ./checks/format.nix {inherit inputs;};
          statix = pkgs.callPackage ./checks/statix.nix {inherit inputs;};
          nvim = pkgs.callPackage ./checks/nvim.nix {
            inherit nixvim system;
            inherit (self.packages.${system}) nvim;
          };
        };

        packages = {
          nvim = pkgs.callPackage ./modules/nixvim/makeNvim.nix {
            inherit inputs system;
            nixvim = nixvim.legacyPackages.${system};
          };
        };

        pre-commit.settings.hooks = {
          alejandra.enable = true;
          prettier.enable = true;
          statix.enable = true;
        };

        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            alejandra
            prettierd
          ];
          nativeBuildInputs = [
            config.pre-commit.settings.package
          ];
          shellHook = ''
            ${config.pre-commit.installationScript}
          '';
        };
      };
    };
}
