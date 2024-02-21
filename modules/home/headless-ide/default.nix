{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.modules.headless-ide;
in
{
  imports = [
    ../dircolors
    ../git
    ../nvim
    ../tmux
    ../zsh
  ];

  options.modules.headless-ide = { enable = mkEnableOption "headless-ide"; };

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
