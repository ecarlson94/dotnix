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
}
