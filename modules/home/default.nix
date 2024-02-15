{ lib, pkgs, config, ... }:

{
  home.stateVersion = "23.11";

  imports = [
    # CLI
    ./zsh
    ./git
    ./dircolors

    # Profiles
    ./headless-ide
  ];

  home.packages = [
    pkgs.curl
    pkgs.wget
  ];
}
