{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.cli;
in {
  imports = [
    ./btop.nix
    ./dircolors.nix
    ./direnv.nix
    ./fish.nix
    ./git.nix
    ./nixvim
    ./tmux.nix
  ];

  options.modules.cli = {enable = mkEnableOption "cli";};

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.scc
    ];

    modules.cli = {
      btop.enable = true;
      dircolors.enable = true;
      direnv.enable = true;
      fish.enable = true;
      git.enable = true;
      nixvim.enable = true;
      tmux.enable = true;
    };
  };
}
