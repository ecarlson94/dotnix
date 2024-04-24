{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.cli.btop;
in {
  options.modules.cli.btop = {enable = mkEnableOption "btop";};

  config = mkIf cfg.enable {
    programs.btop = {
      enable = true;
      catppuccin.enable = true;
    };
  };
}
