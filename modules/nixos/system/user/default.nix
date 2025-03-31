{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  pubKeys = filesystem.listFilesRecursive ./keys;
  sopsHashedPasswordFile = lib.optionalString (!config.isMinimal && !config.wsl.enable) config.sops.secrets."passwords/${config.user.name}".path;
in {
  options = {
    user.name = mkOption {
      type = types.str;
      default = "walawren";
      description = "The name to use for the user account";
    };

    isMinimal = mkOption {
      type = types.bool;
      default = false;
      description = "Used to indicate a minimal host";
    };
  };

  config = {
    users.mutableUsers = config.wsl.enable;

    users.users.${config.user.name} = {
      inherit (config.user) name;
      home = "/home/${config.user.name}";
      isNormalUser = true;
      group = "users";

      hashedPasswordFile = sopsHashedPasswordFile;

      openssh.authorizedKeys.keys = lists.forEach pubKeys (key: builtins.readFile key);

      extraGroups = ["wheel" "networkmanager" "audio" "sound" "video" "input" "tty"];
    };

    # Set fish as default in bash
    programs.bash.interactiveShellInit = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
    programs.fish.enable = true;
  };
}
