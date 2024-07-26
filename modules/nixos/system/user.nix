{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../user
  ];

  users.users.${config.user.name} = {
    inherit (config.user) name;
    home = "/home/${config.user.name}";
    isNormalUser = true;
    group = "users";

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
