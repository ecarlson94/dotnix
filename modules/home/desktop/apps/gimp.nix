{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.desktop.apps.gimp;
in {
  options.modules.desktop.apps.gimp = {enable = mkEnableOption "gimp";};

  config = mkIf cfg.enable {
    home.packages = with pkgs; [gimp];
  };
}
