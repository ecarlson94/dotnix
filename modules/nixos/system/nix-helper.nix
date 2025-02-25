{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.system.nixHelper;
in {
  options.system.nixHelper = {enable = mkEnableOption "nixHelper";};

  config = mkIf cfg.enable {
    programs.nh = {
      enable = true;

      flake = "/home/${config.user.name}/gitrepos/dotnix";
    };
  };
}
