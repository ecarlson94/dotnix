{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  pubKeys = filesystem.listFilesRecursive ./keys;
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

      hashedPasswordFile =
        if !config.isMinimal && !config.wsl.enable
        then config.sops.secrets."passwords/${config.user.name}".path
        else null;
      hashedPassword =
        if config.isMinimal && !config.wsl.enable
        then "$y$j9T$M93AAG05U9RRsjhXIamCL/$YT5Eu.P4ci1hx11vb0P/loGWp6Qpz7hcENtUAj2jryC"
        else null;

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

    systemd.services."persist-home-create-root-paths" = let
      persistentHomesRoot = "/persist";

      listOfCommands =
        lib.mapAttrsToList
        (
          _: user: let
            userHome = lib.escapeShellArg (persistentHomesRoot + user.home);
          in ''
            if [[ ! -d ${userHome} ]]; then
                echo "Persistent home root folder '${userHome}' not found, creating..."
                mkdir -p --mode=${user.homeMode} ${userHome}
                chown ${user.name}:${user.group} ${userHome}
            fi
          ''
        )
        (lib.filterAttrs (_: user: user.createHome == true) config.users.users);

      stringOfCommands = lib.concatLines listOfCommands;
    in {
      script = stringOfCommands;
      unitConfig = {
        Description = "Ensure users' home folders exist in the persistent filesystem";
        PartOf = ["local-fs.target"];
        # The folder creation should happen after the persistent home path is mounted.
        After = ["persist-home.mount"];
      };

      serviceConfig = {
        Type = "oneshot";
        StandardOutput = "journal";
        StandardError = "journal";
      };

      # [Install]
      wantedBy = ["local-fs.target"];
    };
  };
}
