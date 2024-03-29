{ lib, config, ... }:
with lib;
let
  cfg = config.modules.desktop.apps;
in
{
  imports = [
    ./vencord
    ./firefox.nix
    ./kitty.nix
    ./slack.nix
  ];

  options.modules.desktop.apps = { enable = mkEnableOption "apps"; };

  config = mkIf cfg.enable {
    modules.desktop.apps = {
      vencord.enable = true; # Discord
      firefox.enable = true; # Browser
      kitty.enable = true; # Terminal Emulator
      slack.enable = true; # Teams communication
    };
  };
}
