{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.system.cachix;
in {
  options.system.cachix = {enable = mkEnableOption "cachix";};

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      cachix
    ];

    nix.settings.trusted-users = ["root" config.user.name];
  };
}
