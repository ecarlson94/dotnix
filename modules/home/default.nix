{ lib, pkgs, config, ... }:

{
  home.stateVersion = "23.11";

  imports = [
    # CLI
    ./zsh
    ./git
    ./dircolors
    ./nvim

    # Profiles
    ./headless-ide
  ];

  home.packages = [
    pkgs.curl
    pkgs.wget
  ];
}
