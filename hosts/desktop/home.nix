{ config, pkgs, lib, ... }:

{
  imports = [ ../../modules/home ];

  home.username = "walawren";
  home.homeDirectory = "/home/walawren";

  modules.desktop.enable = true;
}
