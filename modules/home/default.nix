{
  inputs,
  theme,
  ...
}: {
  home.stateVersion = "23.11";

  imports = [
    ./cli
    ./gui

    inputs.catppuccin.homeManagerModules.catppuccin
  ];

  catppuccin.flavor = theme.variant;
}
