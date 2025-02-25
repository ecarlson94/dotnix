{
  nixpkgs,
  self,
  ...
}: let
  inherit (self) inputs;

  mkNixosConfiguration = {
    name,
    system ? "x86_64-linux",
    modules,
    homeOptions ? {},
  }:
    nixpkgs.lib.nixosSystem {
      inherit system modules;
      specialArgs = {
        inherit inputs system name homeOptions;
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
          system.stateVersion = "23.11"; # Update when reinstalling

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
          system.stateVersion = "23.11"; # Update when reinstalling

          catppuccin.grub.enable = true;
          boot.loader = {
            efi = {
              canTouchEfiVariables = true;
              efiSysMountPoint = "/boot/efi";
            };
            grub = {
              efiSupport = true;
              device = "nodev";
            };
          };

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

    {
      name = "nixos-virtualbox";
      modules = [
        ./hardware/nixos-virtualbox.nix
        ../modules/nixos
        {
          system.stateVersion = "24.11"; # Update when reinstalling

          boot.loader.grub.enable = true;
          boot.loader.grub.device = "/dev/sda";
          boot.loader.grub.useOSProber = true;
        }
      ];
      homeOptions.cli.enable = true;
    }
  ]
