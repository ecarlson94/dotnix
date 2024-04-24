{
  inputs,
  pkgs,
  ...
}: {
  home.stateVersion = "23.11";

  imports = [
    ./cli
    ./desktop

    inputs.catppuccin.homeManagerModules.catppuccin
  ];

  catppuccin.flavour = "mocha";

  home = {
    packages = [
      pkgs.curl
      pkgs.wget
    ];
  };
}
