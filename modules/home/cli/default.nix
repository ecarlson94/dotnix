{ lib, config, ... }:
with lib;
let
  cfg = config.modules.cli;
in
{
  imports = [
    ./git.nix
    ./nvim.nix
    ./tmux.nix
    ./zsh
  ];

  options.modules.cli = { enable = mkEnableOption "cli"; };

  config = mkIf cfg.enable {
    modules.cli = {
      git.enable = true;
      nvim.enable = true;
      tmux.enable = true;
      zsh.enable = true;
    };
  };
}
