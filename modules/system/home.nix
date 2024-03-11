{ system, inputs, packages, config, homeOptions ? { }, ... }:
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${config.user.name} = {
      imports = [ ../home ]; # Home Options

      home.username = config.user.name;
      home.homeDirectory = "/home/${config.user.name}";
    } // homeOptions;

    # Optionally, use home-manager.extraSpecialArgs to pass
    # arguments to home.nix
    extraSpecialArgs = {
      inherit (packages.${system}) nvim;
      firefox-addons = inputs.firefox-addons.packages.${system};
      theme = import ../../theme;
    };
  };
}
