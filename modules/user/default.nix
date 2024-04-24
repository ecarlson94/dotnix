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
      shell = pkgs.zsh;
      isNormalUser = true;
      group = "users";

      extraGroups = ["wheel" "networkmanager" "audio" "sound" "video" "input" "tty"];
    };

    programs.zsh.enable = true;
  };
}
