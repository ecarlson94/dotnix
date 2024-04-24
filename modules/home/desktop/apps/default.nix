{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.desktop.apps;
in {
  imports = [
    ./vencord
    ./firefox.nix
    ./kitty.nix
    ./slack.nix
    ./spotify.nix
  ];

  options.modules.desktop.apps = {enable = mkEnableOption "apps";};

  config = mkIf cfg.enable {
    modules.desktop.apps = {
      vencord.enable = true;
      firefox.enable = true;
      kitty.enable = true;
      slack.enable = true;
      spotify.enable = true;
    };
  };
}
