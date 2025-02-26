{
  hostSpec,
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
  ];

  home = {
    username = hostSpec.user.name;
    homeDirectory = "/home/${hostSpec.user.name}";
    stateVersion = "23.11"; # Don't change this!!!
  };

  catppuccin.flavor = theme.variant;
}
