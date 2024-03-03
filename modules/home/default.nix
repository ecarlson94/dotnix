{ pkgs, ... }:

{
  home.stateVersion = "23.11";

  imports = [
    ./headless
    ./desktop
  ];

  home.packages = [
    pkgs.curl
    pkgs.wget
  ];
}
