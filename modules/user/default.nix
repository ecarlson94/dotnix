{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.user;

  mkOpt = type: default: description:
    mkOption {inherit type default description;};
in {
  options.user = with types; {
    name = mkOpt str "walawren" "The name to use for the user account";
  };
}
