{inputs, ...}: {
  home.stateVersion = "23.11";

  imports = [
    ./cli
    ./desktop

    inputs.catppuccin.homeManagerModules.catppuccin
  ];

  catppuccin.flavour = "mocha";
}
