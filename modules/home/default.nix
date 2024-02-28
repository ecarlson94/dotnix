{ lib, pkgs, config, ... }:

{
  home.stateVersion = "23.11";

  imports = [
    # CLI
    ./dircolors
    ./git
    ./nvim
    ./tmux
    ./zsh

    # Profiles
    ./headless-ide
  ];

  home.packages = [
    pkgs.curl
    pkgs.wget
  ];
}
