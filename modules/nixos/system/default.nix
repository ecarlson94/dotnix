{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.system;
in {
  imports = [
    ./cachix.nix
    ./docker.nix
    ./nix-helper.nix
  ];

  options.system = {enable = mkEnableOption "system";};

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      curl
      wget
    ];

    system = {
      cachix.enable = true;
      docker.enable = true;
      nixHelper.enable = true;
    };
  };
}
