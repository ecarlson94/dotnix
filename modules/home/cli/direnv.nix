{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.cli.direnv;
in {
  options.cli.direnv = {enable = mkEnableOption "direnv";};

  config = mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
