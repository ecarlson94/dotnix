{ config, pkgs, lib, ... }:

{
  imports = [ ../../modules/home/default.nix ];

  home.username = "nixos";
  home.homeDirectory = "/home/nixos";

  modules = {
    zsh.enable = true;
    git.enable = true;
    nvim.enable = true;
  };
}
