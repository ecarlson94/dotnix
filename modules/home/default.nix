{ lib, pkgs, config, ... }:

{
  home.stateVersion = "23.11";

  imports = [
    # CLI
    ./dircolors.nix
    ./git.nix
    ./nvim.nix
    ./tmux.nix
    ./zsh

    # Profiles
    ./headless-ide.nix
  ];

  home.packages = [
    pkgs.curl
    pkgs.wget
  ];
}
