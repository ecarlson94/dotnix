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
      modules = [
        ../modules/nixos
        {
          wsl.enable = true;
        }
      ];
      name = "nixos-wsl";
      homeOptions.cli = {
        enable = true;
        wsl.enable = true;
      };
    }

    {
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
      name = "nixos-desktop";
      homeOptions.ui = {
        enable = true;
        nixos.enable = true;
      };
    }
  ]
