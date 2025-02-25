{
  inputs,
  pkgs,
  name,
  config,
  ...
}: {
  imports = [
    inputs.nixos-wsl.nixosModules.wsl

    ./cachix.nix
    ./docker.nix
    ./nix-helper.nix
    ./user.nix
  ];

  environment.systemPackages = with pkgs; [
    curl
    wget
  ];

  wsl.defaultUser = config.user.name;
  programs.dconf.enable = config.wsl.enable; # Configuration System & Setting Management - required for Home Manager

  networking = {
    hostName = name;

    networkmanager.enable = !config.wsl.enable;
    firewall.enable = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = _: true;

  nix = {
    settings.experimental-features = ["nix-command" "flakes"];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 10d";
      persistent = true;
    };
  };

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  system = {
    autoUpgrade = {
      enable = true;
      flake = "github:ecarlson94/dotnix";
      persistent = true;
    };

    cachix.enable = true;
    docker.enable = true;
    nixHelper.enable = true;
  };
}
