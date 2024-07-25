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

  nix.settings.experimental-features = ["nix-command" "flakes"];

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
    cachix.enable = true;
    docker.enable = true;
    nixHelper.enable = true;

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It's perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    stateVersion = "23.11"; # Did you read the comment?
  };
}
