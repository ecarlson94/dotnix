{ pkgs, inputs, ... }:

{
  home.stateVersion = "23.11";

  imports = [
    inputs.hypridle.homeManagerModules.hypridle
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
