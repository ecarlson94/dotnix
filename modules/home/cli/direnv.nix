{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.cli.direnv;
in {
  options.modules.cli.direnv = {enable = mkEnableOption "direnv";};

  config = mkIf cfg.enable {
    programs = {
      direnv = {
        enable = true;
        enableZshIntegration = true;
        nix-direnv.enable = true;
      };
    };
  };
}
