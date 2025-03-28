{
  config,
  hostConfig,
  lib,
  ...
}:
with lib; let
  cfg = config.cli.btop;
in {
  options.cli.btop = {enable = mkEnableOption "btop";};

  config = mkIf cfg.enable {
    catppuccin.btop.enable = true;
    programs.btop = {
      enable = true;
    };

    home.persistence."/persist${config.home.homeDirectory}" = mkIf hostConfig.system.impermanence.enable {
      directories = [".config/btop"];
    };
  };
}
