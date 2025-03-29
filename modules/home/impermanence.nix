{
  config,
  hostConfig,
  inputs,
  lib,
  ...
}:
with lib; {
  imports = [inputs.impermanence.homeManagerModules.impermanence];

  config = mkIf hostConfig.system.impermanence.enable {
    home.persistence."/persist${config.home.homeDirectory}" = {
      directories = [
        "Documents"
        "Downloads"
        "Music"
        "Pictures"
        "Videos"
        "gitrepos"
        ".config/dconf"
        ".config/nix"
        ".gnupg"
        ".local/share/keyrings"
        ".local/state/home-manager"
        ".ssh"
        {
          directory = ".local/share/Steam";
          method = "symlink";
        }
      ];
      files = [
        ".manpath"
        ".nix-profile"
        ".screenrc"
      ];
      allowOther = true;
    };
  };
}
