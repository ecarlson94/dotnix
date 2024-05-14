{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.desktop.apps;
in {
  imports = [
    ./firefox.nix
    ./gimp.nix
    ./kitty.nix
    ./slack.nix
    ./spotify.nix
    ./teams.nix
    ./vencord
  ];

  options.modules.desktop.apps = {enable = mkEnableOption "apps";};

  config = mkIf cfg.enable {
    modules.desktop.apps = {
      firefox.enable = true;
      gimp.enable = true;
      kitty.enable = true;
      slack.enable = true;
      spotify.enable = true;
      teams.enable = true;
      vencord.enable = true;
    };
  };
}
