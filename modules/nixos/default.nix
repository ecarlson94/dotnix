{
  inputs,
  config,
  ...
}: {
  imports = [
    ./home.nix
    ./system
    ./ui
    ../user
    inputs.nixos-wsl.nixosModules.wsl
  ];

  wsl.defaultUser = config.user.name;
  programs.dconf.enable = config.wsl.enable; # Configuration System & Setting Management - required for Home Manager
}
