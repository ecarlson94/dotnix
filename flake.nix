{
  description = "NixOS configuration";

  inputs = {
    # Repo configuration dependencies
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    cachix-deploy-flake = {
      url = "github:cachix/cachix-deploy-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        disko.follows = "disko";
        home-manager.follows = "home-manager";
      };
    };

    # User configuration dependencies
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
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
    firefox-addons,
    cachix-deploy-flake,
    home-manager,
    nixpkgs,
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
        f rec {
          inherit system;
          pkgs = pkgsFor.${system};
          cachix-deploy-lib = cachix-deploy-flake.lib pkgs;
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

    formatter = forEachSystem ({pkgs, ...}:
      pkgs.writeShellApplication {
        name = "dotnix-format";
        text = ''
          ${pkgs.alejandra}/bin/alejandra .
          ${pkgs.nodePackages.prettier}/bin/prettier --write .
          ${pkgs.shfmt}/bin/shfmt -l -w -i 2 -ci .
        '';
      });

    checks = forEachSystem ({pkgs, ...}: {
      format = pkgs.callPackage ./checks/format.nix {inherit inputs;};
      statix = pkgs.callPackage ./checks/statix.nix {inherit inputs;};
    });

    nixosModules = import ./modules/nixos;
    homeManagerModules.dotnix = import ./modules/home;

    nixosConfigurations = import ./hosts inputs;

    packages = forEachSystem ({
      cachix-deploy-lib,
      pkgs,
      ...
    }: {
      cachix-deploy-spec = cachix-deploy-lib.spec {
        agents = {
          nixos-virtualbox = self.nixosConfigurations.nixos-virtualbox.config.system.build.toplevel;
        };
      };
    });

    devShells = forEachSystem ({pkgs, ...}: {
      default = pkgs.mkShell {
        packages = with pkgs; [
          age
          alejandra
          cachix
          nodePackages.prettier
          shfmt
          sops
          ssh-to-age
          yq-go
        ];
      };
    });
  };
}
