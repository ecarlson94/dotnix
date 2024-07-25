{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.ui.apps;
in {
  imports = [
    ./firefox.nix
    ./kitty.nix
    ./slack.nix
    ./spotify.nix
    ./teams.nix
    ./vencord
  ];

  options.modules.ui.apps = {enable = mkEnableOption "apps";};

  config = mkIf cfg.enable {
    modules.ui.apps = {
      firefox.enable = true;
      kitty.enable = true;
      slack.enable = true;
      spotify.enable = true;
      teams.enable = true;
      vencord.enable = true;
    };
  };
}
