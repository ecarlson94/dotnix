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

          boot.loader.grub = {
            enable = true;
            device = "/dev/sda";
            useOSProber = true;
          };

          # Enable SSH
          services.openssh = {
            enable = true;
            ports = [22];
            settings = {
              PasswordAuthentication = false;
              StreamLocalBindUnlink = "yes";
              PermitRootLogin = "no"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
              GatewayPorts = "clientspecified";
            };

            hostKeys = [
              {
                path = "/etc/ssh/ssh_host_ed25519_key";
                type = "ed25519";
              }
            ];
          };

          services.fail2ban = {
            enable = true;
            ignoreIP = [
              # Whitelist some subnets
              "10.0.0.0/8"
              "172.16.0.0/12"
              "192.168.0.0/16"
              "8.8.8.8" # whitelist a specific IP
              "nixos.wiki" # resolve the IP via DNS
            ];
          };

          networking.firewall.allowedTCPPorts = [22];

          # user.name = "kiri";
        }
      ];
      homeOptions.cli.enable = true;
    }
  ]
