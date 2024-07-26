{
  system,
  inputs,
  config,
  theme,
  homeOptions ? {},
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ../user
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${config.user.name} =
      {
        imports = [
          ../home
        ]; # Home Options
      }
      // homeOptions;

    # Optionally, use home-manager.extraSpecialArgs to pass
    # arguments to home.nix
    extraSpecialArgs = {
      inherit inputs system theme;
    };
  };
}
