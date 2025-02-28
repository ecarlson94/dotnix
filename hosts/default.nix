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
        inputs.disko.nixosModules.disko
        (import ./disko.nix {
          inherit (nixpkgs) lib;
          device = "/dev/sda";
        })

        inputs.impermanence.nixosModules.impermanence
        ./hardware/nixos-virtualbox.nix
        ../modules/nixos
        {
          system.stateVersion = "24.11"; # Update when reinstalling

          boot.loader.grub = {
            enable = true;
            device = "/dev/sda";
            useOSProber = true;
          };

          boot.initrd.postDeviceCommands = nixpkgs.lib.mkAfter ''
            mkdir /btrfs_tmp
            mount /dev/root_vg/root /btrfs_tmp
            if [[ -e /btrfs_tmp/root ]]; then
                mkdir -p /btrfs_tmp/old_roots
                timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
                mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
            fi

            delete_subvolume_recursively() {
                IFS=$'\n'
                for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
                    delete_subvolume_recursively "/btrfs_tmp/$i"
                done
                btrfs subvolume delete "$1"
            }

            for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +30); do
                delete_subvolume_recursively "$i"
            done

            btrfs subvolume create /btrfs_tmp/root
            umount /btrfs_tmp
          '';

          fileSystems."/persist".neededForBoot = true;
          environment.persistence."/persist/system" = {
            hideMounts = true;
            directories = [
              "/etc/nixos"
              "/var/log"
              "/var/lib/bluetooth"
              "/var/lib/nixos"
              "/var/lib/systemd/coredump"
              "/etc/NetworkManager/system-connections"
              {
                directory = "/var/lib/colord";
                user = "colord";
                group = "colord";
                mode = "u=rwx,g=rx,o=";
              }
            ];
            files = [
              "/etc/machine-id"
              {
                file = "/var/keys/secret_file";
                parentDirectory = {mode = "u=rwx,g=,o=";};
              }
            ];
          };

          programs.fuse.userAllowOther = true; # Needed for home-manager impermanence

          system.openssh.enable = true;

          # user.name = "kiri";
        }
      ];
      homeOptions.cli.enable = true;
    }
  ]
