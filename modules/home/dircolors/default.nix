{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.modules.dircolors;
in
{
  options.modules.dircolors = { enable = mkEnableOption "dircolors"; };

  config = mkIf cfg.enable {
    programs.dircolors.enable = true;
    programs.dircolors.enableBashIntegration = true;
  };
}
