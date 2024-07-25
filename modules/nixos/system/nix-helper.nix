{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.system.nixHelper;
in {
  options.system.nixHelper = {enable = mkEnableOption "nixHelper";};

  config = mkIf cfg.enable {
    programs.nh = {
      enable = true;

      clean = {
        enable = true;
        dates = "weekly";
        extraArgs = "--keep-since 10d --keep 10";
      };

      flake = "/home/${config.user.name}/gitrepos/dotnix";
    };
  };
}
