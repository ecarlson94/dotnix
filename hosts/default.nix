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
          system = {
            stateVersion = "23.11"; # Update when reinstalling
            docker.enable = true;
          };

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
          system = {
            stateVersion = "23.11"; # Update when reinstalling
            docker.enable = true;
            bootloader.grub.enable = true;
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
      name = "nixos-framework13";
      modules = [
        inputs.disko.nixosModules.disko
        (import ./disko.nix {
          inherit (nixpkgs) lib;
          device = "/dev/nvme0n1";
        })

        inputs.nixos-hardware.nixosModules.framework-amd-ai-300-series
        ../modules/nixos

        {
          system = {
            stateVersion = "25.05"; # Update when reinstalling
            docker.enable = true;
            bootloader.grub.enable = true;
          };

          services.fwupd.enable = true;

          ui = {
            enable = true;
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
        inputs.disko.nixosModules.disko
        (import ./disko.nix {
          inherit (nixpkgs) lib;
          device = "/dev/sda";
        })

        ./hardware/nixos-virtualbox.nix
        ../modules/nixos

        {
          system.stateVersion = "25.05"; # Update when reinstalling

          boot.loader = {
            efi.canTouchEfiVariables = true;
            systemd-boot.enable = true;
          };

          system = {
            cachix-agent.enable = true;
            openssh.enable = true;
            ddns = {
              enable = true;
              domains = ["walawren.com"];
            };
          };

          user.name = "kiri";
        }
      ];

      homeOptions.cli = {
        btop.enable = true;
        dircolors.enable = true;
        fish.enable = true;
        tmux.enable = true;
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
                initialHashedPassword = mkForce "$y$j9T$M93AAG05U9RRsjhXIamCL/$YT5Eu.P4ci1hx11vb0P/loGWp6Qpz7hcENtUAj2jryC";
                openssh.authorizedKeys.keys = lists.forEach pubKeys (key: builtins.readFile key);
              };
              nixos = {
                initialHashedPassword = mkForce "$y$j9T$M93AAG05U9RRsjhXIamCL/$YT5Eu.P4ci1hx11vb0P/loGWp6Qpz7hcENtUAj2jryC";
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
  ]
