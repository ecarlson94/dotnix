{
  config,
  inputs,
  theme,
  ...
}: {
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = _: true;

  imports = [
    ./cli
    ./ui
    ../user

    inputs.catppuccin.homeManagerModules.catppuccin
  ];

  home = {
    username = config.user.name;
    homeDirectory = "/home/${config.user.name}";
    stateVersion = "23.11"; # Don't change this!!!
  };

  catppuccin.flavor = theme.variant;
}
