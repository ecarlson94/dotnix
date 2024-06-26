{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.gui.apps;
in {
  imports = [
    ./firefox.nix
    ./kitty.nix
    ./slack.nix
    ./spotify.nix
    ./teams.nix
    ./vencord
  ];

  options.modules.gui.apps = {enable = mkEnableOption "apps";};

  config = mkIf cfg.enable {
    modules.gui.apps = {
      firefox.enable = true;
      kitty.enable = true;
      slack.enable = true;
      spotify.enable = true;
      teams.enable = true;
      vencord.enable = true;
    };
  };
}
