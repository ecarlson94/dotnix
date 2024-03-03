{ config, pkgs, lib, ... }:

{
  imports = [ ../../modules/home ];

  home.username = "walawren";
  home.homeDirectory = "/home/walawren";

  modules.headless-ide.enable = true;
}
