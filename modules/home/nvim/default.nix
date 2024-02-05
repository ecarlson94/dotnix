{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.modules.nvim;
in {
  options.modules.nvim = { enable = mkEnableOption "nvim"; };

  config = mkIf cfg.enable {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
    };

    programs.zsh.shellAliases = {
      vi = "nvim";
    };
  };
}
