{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.modules.nvim;
in {
  imports = [ ../search ];

  options.modules.nvim = { enable = mkEnableOption "nvim"; };

  config = mkIf cfg.enable {
    modules.search.enable = true;

    programs.neovim = {
      enable = true;
      defaultEditor = true;
    };

    programs.zsh.shellAliases = {
      vi = "nvim";
    };
  };
}
