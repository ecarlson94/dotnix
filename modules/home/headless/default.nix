{ lib, config, ... }:
with lib;
let
  cfg = config.modules.headless;
in
{
  imports = [
    ./dircolors.nix
    ./git.nix
    ./nvim.nix
    ./tmux.nix
    ./zsh
  ];

  options.modules.headless = { enable = mkEnableOption "headless"; };

  config = mkIf cfg.enable {
    modules = {
      dircolors.enable = true;
      git.enable = true;
      nvim.enable = true;
      tmux.enable = true;
      zsh.enable = true;
    };
  };
}
