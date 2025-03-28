{
  hostConfig,
  inputs,
  lib,
  ...
}:
with lib; {
  imports = [inputs.impermanence.homeManagerModules.impermanence];

  config = mkIf hostConfig.system.impermanence.enable {
    home.persistence."/persist/home" = {
      directories = [
        "Documents"
        "Downloads"
        "Music"
        "Pictures"
        "Videos"
        "gitrepos"
        ".config/dconf"
        ".config/environment.d"
        ".config/nix"
        ".config/systemd"
        ".gnupg"
        ".local/share/keyrings"
        ".local/state/home-manager"
        ".local/state/nix"
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
