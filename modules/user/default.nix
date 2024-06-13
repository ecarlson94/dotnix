{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.user;

  home = "/home/${cfg.name}";

  mkOpt = type: default: description:
    mkOption {inherit type default description;};
in {
  options.user = with types; {
    name = mkOpt str "walawren" "The name to use for the user account";
  };

  config = {
    users.users.${cfg.name} = {
      inherit home;
      inherit (cfg) name;
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
  };
}
