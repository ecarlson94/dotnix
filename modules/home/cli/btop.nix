{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.cli.btop;
in {
  options.cli.btop = {enable = mkEnableOption "btop";};

  config = mkIf cfg.enable {
    programs.btop = {
      enable = true;
      catppuccin.enable = true;
    };
  };
}
