{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.gui.apps.teams;
in {
  options.modules.gui.apps.teams = {enable = mkEnableOption "teams";};

  config = mkIf cfg.enable {
    home.packages = with pkgs; [teams-for-linux];
  };
}
