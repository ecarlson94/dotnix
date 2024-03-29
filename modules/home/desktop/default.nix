{ lib, config, ... }:
with lib;
let
  cfg = config.modules.desktop;
in
{
  imports = [
    ../cli

    ./apps
    ./nixos

    ./fonts.nix
  ];

  options.modules.desktop = { enable = mkEnableOption "desktop"; };

  config = mkIf cfg.enable {
    programs.dircolors.enable = true;
    modules = {
      cli.enable = true;

      desktop = {
        apps = {
          vencord.enable = true;
          firefox.enable = true; # Browser
          kitty.enable = true; # Terminal Emulator
          slack.enable = true; # Teams communication
        };
      };
    };
  };
}
