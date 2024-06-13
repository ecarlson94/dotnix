{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.cli.dircolors;
in {
  options.modules.cli.dircolors = {enable = mkEnableOption "dircolors";};

  config = mkIf cfg.enable {
    programs.dircolors.enable = true;
  };
}
