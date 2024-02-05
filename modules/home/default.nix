{ lib, pkgs, config, ... }:

{
  home.stateVersion = "23.11";

  imports = [
    # cli
    ./zsh
    ./git
    ./nvim
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
    enableBashIntegration = true;
    defaultCommand = "fd --type f --color=always";
    defaultOptions = [ "-m" "--height 50%" "--border" ];
  };
}
