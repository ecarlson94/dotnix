{
  config,
  lib,
  pkgs,
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

    nix = {
      settings = {
        trusted-users = ["root" config.user.name];

        substituters = [
          "https://cache.nixos.org"
          "https://ecarlson94.cachix.org"
        ];
        trusted-public-keys = [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "ecarlson94.cachix.org-1:o8CIAZqOFdOpBOMdjJ05UVSb9GBWaPNK2ZEEfbXJn3I="
        ];
      };
    };
  };
}
