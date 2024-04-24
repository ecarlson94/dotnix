{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.desktop.apps.teams;
in {
  options.modules.desktop.apps.teams = {enable = mkEnableOption "teams";};

  config = mkIf cfg.enable {
    home.packages = with pkgs; [teams-for-linux];
  };
}
