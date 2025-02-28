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
    inputs.impermanence.homeManagerModules.impermanence
  ];

  home = {
    username = hostSpec.user.name;
    homeDirectory = "/home/${hostSpec.user.name}";
    stateVersion = "23.11"; # Don't change this!!!

    persistence."/persist/home" = {
      directories = [
        "Downloads"
        "Music"
        "Pictures"
        "Documents"
        "Videos"
        ".gitrepos"
        ".gnupg"
        ".ssh"
        ".local/share/keyrings"
        ".local/share/direnv"
        {
          directory = ".local/share/Steam";
          method = "symlink";
        }
      ];
      files = [
        ".screenrc"
      ];
      allowOther = true;
    };
  };

  catppuccin.flavor = theme.variant;
}
