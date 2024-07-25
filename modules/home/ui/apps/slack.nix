{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.ui.apps.slack;
in {
  options.modules.ui.apps.slack = {enable = mkEnableOption "slack";};

  config = mkIf cfg.enable {
    home.packages = with pkgs; [slack];
  };
}
