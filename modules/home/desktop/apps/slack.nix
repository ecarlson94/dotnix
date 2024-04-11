{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.desktop.apps.slack;
in {
  options.modules.desktop.apps.slack = {enable = mkEnableOption "slack";};

  config = mkIf cfg.enable {
    home.packages = with pkgs; [slack];
  };
}
