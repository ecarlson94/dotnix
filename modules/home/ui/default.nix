{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.ui;
in {
  imports = [
    ../cli

    ./apps
    ./nixos

    ./fonts.nix
    ./cursors.nix
  ];

  options.ui = {enable = mkEnableOption "ui";};

  config = mkIf cfg.enable {
    cli.enable = true;
    ui = {
      cursors.enable = true;
      apps.enable = true;
    };
  };
}
