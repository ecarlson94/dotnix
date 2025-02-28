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
        ({
          config,
          lib,
          pkgs,
          ...
        }:
          with lib; let
            pubKeys = filesystem.listFilesRecursive ../modules/nixos/system/user/keys;
          in {
            imports = [
              "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
              "${nixpkgs}/nixos/modules/installer/cd-dvd/channel.nix"
            ];

            users.users = {
              root = {
                initialHashedPassword = mkForce "$y$j9T$VqYNiu.QjWYAhZSwrWJ4i/$OHA.qHe7gzild.lXv2cV/k4olYHakR1NqOJlr4PRlyA";
                openssh.authorizedKeys.keys = lists.forEach pubKeys (key: builtins.readFile key);
              };
              nixos = {
                initialHashedPassword = mkForce "$y$j9T$VqYNiu.QjWYAhZSwrWJ4i/$OHA.qHe7gzild.lXv2cV/k4olYHakR1NqOJlr4PRlyA";
                openssh.authorizedKeys.keys = lists.forEach pubKeys (key: builtins.readFile key);
              };
            };

            nix.settings.experimental-features = ["nix-command" "flakes"];

            # The default compression-level is (6) and takes too long on some machines (>30m). 3 takes <2m
            isoImage.squashfsCompression = "zstd -Xcompression-level 3";

            nixpkgs = {
              hostPlatform = lib.mkDefault "x86_64-linux";
              config.allowUnfree = true;
            };

            services = {
              openssh = {
                enable = true;
                ports = [22];
                settings = {
                  PermitRootLogin = lib.mkForce "yes";
                };
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

        ({lib, ...}:
          with lib; let
            pubKeys = filesystem.listFilesRecursive ../modules/nixos/system/user/keys;
          in {
            system.stateVersion = "24.11"; # Update when reinstalling

            boot.loader = {
              efi.canTouchEfiVariables = true;
              systemd-boot.enable = true;
            };

            system = {
              openssh.enable = true;
              impermanence.enable = true;
            };

            user.name = "kiri";

            # Uncomment for remote installation
            services.openssh.settings.PermitRootLogin = lib.mkForce "yes";
            users.users.root = {
              openssh.authorizedKeys.keys = lists.forEach pubKeys (key: builtins.readFile key);
            };
          })
      ];

      homeOptions.cli.enable = true;
    }
  ]
