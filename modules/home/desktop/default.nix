{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.desktop;
in {
  imports = [
    ../cli

    ./apps
    ./nixos

    ./fonts.nix
    ./cursors.nix
  ];

  options.modules.desktop = {enable = mkEnableOption "desktop";};

  config = mkIf cfg.enable {
    modules = {
      cli.enable = true;
      desktop = {
        cursors.enable = true;
        apps.enable = true;
      };
    };
  };
}
