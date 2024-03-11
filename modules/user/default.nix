{ lib, config, pkgs, ... }:
with lib;
let
  cfg = config.user;

  mkOpt = type: default: description:
    mkOption { inherit type default description; };
in
{
  options.user = with types; {
    name = mkOpt str "walawren" "The name to use for the user account";
  };

  config = {
    users.users.${cfg.name} = {
      inherit (cfg) name;
      shell = pkgs.zsh;
      isNormalUser = true;
      home = "/home/${cfg.name}";
      group = "users";

      extraGroups = [ "wheel" "networkmanager" "audio" "sound" "video" "input" "tty" "docker" ];
    };

    programs.zsh.enable = true;
  };
}
