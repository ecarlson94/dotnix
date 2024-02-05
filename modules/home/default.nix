{ lib, pkgs, config, ... }:

{
  home.stateVersion = "23.11";

  imports = [
    # cli
    ./zsh
    ./git
  ];

  home.packages = [
    pkgs.curl
    pkgs.fd
    pkgs.vim
    pkgs.wget
  ];

  programs.ripgrep.enable = true;
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "fd --type f --color=always";
    defaultOptions = [ "-m" "--height 50%" "--border" ];
  };
}
