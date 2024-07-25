{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.ui;
in {
  imports = [
    ../cli

    ./apps
    ./nixos

    ./fonts.nix
    ./cursors.nix
  ];

  options.modules.ui = {enable = mkEnableOption "ui";};

  config = mkIf cfg.enable {
    modules = {
      cli.enable = true;
      ui = {
        cursors.enable = true;
        apps.enable = true;
      };
    };
  };
}
