{
  nixpkgs,
  self,
  ...
}: let
  inherit (self) inputs packages;

  mkNixosConfiguration = {
    name,
    system ? "x86_64-linux",
    modules,
    homeOptions ? {},
  }:
    nixpkgs.lib.nixosSystem {
      inherit system modules;
      specialArgs = {
        inherit inputs system packages name homeOptions;
        theme = import ../theme;
      };
    };

  mkNixosConfigurations = nixpkgs.lib.foldl (
    acc: conf:
      {
        "${conf.name}" = mkNixosConfiguration conf;
      }
      // acc
  ) {};
in
  mkNixosConfigurations [
    {
      name = "nixos-wsl";
      modules = [
        ../modules/nixos
        {
          wsl.enable = true;
        }
      ];
      homeOptions.cli = {
        enable = true;
        wsl.enable = true;
      };
    }

    {
      name = "nixos-desktop";
      modules = [
        ./hardware/nixos-desktop.nix
        ../modules/nixos
        {
          ui = {
            enable = true;
            gaming.enable = true;
          };
        }
      ];
      homeOptions.ui = {
        enable = true;
        nixos.enable = true;
      };
    }
  ]
