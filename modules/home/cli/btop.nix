{
  config,
  lib,
  hostConfig,
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

    home.persistence."/persist/home" = mkIf hostConfig.system.impermanence.enable {
      directories = [".config/btop"];
    };
  };
}
