{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.gui.apps.slack;
in {
  options.modules.gui.apps.slack = {enable = mkEnableOption "slack";};

  config = mkIf cfg.enable {
    home.packages = with pkgs; [slack];
  };
}
