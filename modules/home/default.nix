{
  hostConfig,
  inputs,
  theme,
  ...
}: {
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = _: true;

  imports = [
    ./cli
    ./sops.nix
    ./ui

    inputs.catppuccin.homeManagerModules.catppuccin
    inputs.impermanence.homeManagerModules.impermanence
  ];

  home = {
    username = hostConfig.user.name;
    homeDirectory = "/home/${hostConfig.user.name}";
    stateVersion = "23.11"; # Don't change this!!!
  };

  catppuccin.flavor = theme.variant;
}
