{
  config,
  lib,
  pkgs,
  ...
}: let
  pubKeys = lib.filesystem.listFilesRecursive ./keys;
in {
  imports = [
    ../../../user
  ];

  sops.secrets."passwords/${config.user.name}".neededForUsers = !config.wsl.enable;
  users.mutableUsers = config.wsl.enable;

  users.users.${config.user.name} = {
    inherit (config.user) name;
    home = "/home/${config.user.name}";
    isNormalUser = true;
    group = "users";

    hashedPasswordFile =
      if config.wsl.enable
      then null
      else config.sops.secrets."passwords/${config.user.name}".path;

    openssh.authorizedKeys.keys = lib.lists.forEach pubKeys (key: builtins.readFile key);

    extraGroups = ["wheel" "networkmanager" "audio" "sound" "video" "input" "tty"];
  };

  # Set fish as default in bash
  programs.bash = {
    interactiveShellInit = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };
  programs.fish.enable = true;
}
