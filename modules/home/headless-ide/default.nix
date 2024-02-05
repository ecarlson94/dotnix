{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.modules.headless-ide;
in {
  imports = [
    ../git
    ../zsh
    ../nvim
    ../tmux
  ];

  options.modules.headless-ide = { enable = mkEnableOption "headless-ide"; };

  config = mkIf cfg.enable {
    modules = {
      git.enable = true;
      zsh.enable = true;
      nvim.enable = true;
      tmux.enable = true;
    };
  };
}
