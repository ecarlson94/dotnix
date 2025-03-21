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

    nix = {
      settings = {
        trusted-users = ["root" config.user.name];

        substituters = [
          "https://cache.nixos.org"
          "https://freewavetechnologies.cachix.org"
          "https://ecarlson94.cachix.org"
        ];
        trusted-public-keys = [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "freewavetechnologies.cachix.org-1:wwgyGJwjLPZStMivX9BPgVj6qYn24kGh88U4Mnrur98="
          "ecarlson94.cachix.org-1:o8CIAZqOFdOpBOMdjJ05UVSb9GBWaPNK2ZEEfbXJn3I="
        ];
      };
    };
  };
}
