{
  system,
  inputs,
  packages,
  config,
  homeOptions ? {},
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  nixpkgs.config.allowUnfreePredicate = _: true;

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${config.user.name} =
      {
        imports = [
          ../home
        ]; # Home Options

        home.username = config.user.name;
        home.homeDirectory = "/home/${config.user.name}";
      }
      // homeOptions;

    # Optionally, use home-manager.extraSpecialArgs to pass
    # arguments to home.nix
    extraSpecialArgs = {
      inherit (packages.${system}) nvim;
      inherit inputs;
      firefox-addons = inputs.firefox-addons.packages.${system};
      theme = import ../../theme;
    };
  };
}
