{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.gui;
in {
  imports = [
    ../cli

    ./apps
    ./nixos

    ./fonts.nix
    ./cursors.nix
  ];

  options.modules.gui = {enable = mkEnableOption "gui";};

  config = mkIf cfg.enable {
    modules = {
      cli.enable = true;
      gui = {
        cursors.enable = true;
        apps.enable = true;
      };
    };
  };
}
