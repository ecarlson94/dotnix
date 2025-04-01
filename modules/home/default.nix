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
    ./impermanence.nix
    ./sops.nix
    ./ui

    inputs.catppuccin.homeModules.catppuccin
  ];

  home = {
    inherit (hostConfig.system) stateVersion; # Don't change this!!!
    username = hostConfig.user.name;
    homeDirectory = hostConfig.users.users.${hostConfig.user.name}.home;
  };

  catppuccin.flavor = theme.variant;
}
