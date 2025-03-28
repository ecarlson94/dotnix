{
  config,
  lib,
  hostConfig,
  ...
}:
with lib; let
  cfg = config.cli.dircolors;
in {
  options.cli.dircolors = {enable = mkEnableOption "dircolors";};

  config = mkIf cfg.enable {
    programs.dircolors.enable = true;

    home.persistence."/persist/home" = mkIf hostConfig.system.impermanence.enable {
      files = [".dir_colors"];
    };
  };
}
