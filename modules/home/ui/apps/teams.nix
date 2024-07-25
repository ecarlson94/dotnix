{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.ui.apps.teams;
in {
  options.modules.ui.apps.teams = {enable = mkEnableOption "teams";};

  config = mkIf cfg.enable {
    home.packages = with pkgs; [teams-for-linux];
  };
}
