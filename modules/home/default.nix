{ pkgs, inputs, ... }:

{
  home.stateVersion = "23.11";

  imports = [
    inputs.hyprlock.homeManagerModules.hyprlock
    ./cli
    ./desktop
  ];

  home = {
    packages = [
      pkgs.curl
      pkgs.wget
    ];
  };
}
