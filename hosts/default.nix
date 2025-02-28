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
      name = "nixos-installer";
      modules = [
        ../modules/nixos
        ({
          config,
          lib,
          pkgs,
          ...
        }: {
          imports = [
            "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
            "${nixpkgs}/nixos/modules/installer/cd-dvd/channel.nix"
          ];

          isIsoInstaller = true;

          users.users.root = {
            initialHashedPassword = lib.mkForce "$y$j9T$xSz5Lw5OWMZ39pHrpPGdz.$jrnf14I1OzVUJZLy2Dq8D6/D.vYQ28fT4kfRVvoT8/0";
            openssh.authorizedKeys.keys =
              config.users.users.${config.user.name}.openssh.authorizedKeys.keys;
          };

          # The default compression-level is (6) and takes too long on some machines (>30m). 3 takes <2m
          isoImage.squashfsCompression = "zstd -Xcompression-level 3";

          nixpkgs = {
            hostPlatform = lib.mkDefault "x86_64-linux";
            config.allowUnfree = true;
          };

          services = {
            qemuGuest.enable = true;
            openssh = {
              ports = [22];
              settings.PermitRootLogin = lib.mkForce "yes";
            };
          };

          boot = {
            kernelPackages = pkgs.linuxPackages_latest;
            supportedFilesystems = lib.mkForce [
              "btrfs"
              "vfat"
            ];
          };
        })
      ];
    }

    {
      name = "nixos-virtualbox";
      modules = [
        inputs.disko.nixosModules.disko
        (import ./disko.nix {
          inherit (nixpkgs) lib;
          device = "/dev/sda";
        })

        ./hardware/nixos-virtualbox.nix
        ../modules/nixos
        {
          system.stateVersion = "24.11"; # Update when reinstalling

          boot.loader.grub = {
            enable = true;
            device = "/dev/sda";
            useOSProber = true;
          };

          system = {
            openssh.enable = true;
            impermanence.enable = true;
          };

          # user.name = "kiri";
        }
      ];

      homeOptions.cli = {
        fish.enable = true;
        tmux.enable = true;
      };
    }
  ]
