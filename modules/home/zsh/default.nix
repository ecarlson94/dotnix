{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.modules.zsh;
in {
  options.modules.zsh = { enable = mkEnableOption "zsh"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.python3Minimal # djui/alias-tips needs this
      pkgs.zsh
    ];

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      syntaxHighlighting.enable = true;

      zplug = {
        enable = true;
        plugins = [
          { name = "zsh-users/zsh-autosuggestions"; } # Simple plugin installation
          { name = "jeffreytse/zsh-vi-mode"; }
          { name = "djui/alias-tips"; }
          { name = "hlissner/zsh-autopair"; tags = [ defer:2 ]; }
          { name = "zsh-users/zsh-history-substring-search"; tags = [ as:plugin ]; }
          { name = "bric3/nice-exit-code"; }
        ];
      };

      plugins = [
        {
          name = "powerlevel10k";
          src = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k";
          file = "powerlevel10k.zsh-theme";
        }
        {
          name = "powerlevel10k-config";
          src = ./p10k-config;
          file = "p10k.zsh";
        }
      ];
    };
  };
}
