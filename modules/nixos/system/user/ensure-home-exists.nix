{
  config,
  lib,
  ...
}: {
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
      (lib.filterAttrs (_: user: user.createHome) config.users.users);

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
}
