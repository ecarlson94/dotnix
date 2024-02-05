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
      pkgs.scc
    ];

    programs.dircolors.enable = true;
    programs.dircolors.enableZshIntegration = true;

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      syntaxHighlighting = {
        enable = true;
        highlighters = [
          "main"
          "brackets"
          "pattern"
          "cursor"
          "line"
        ];
        styles = {
          cursor = "fg=yellow,bold";
          default = "none";
          unknown-token = "fg=green,bold";
          reserved-word = "fg=green,bold";
          alias = "fg=cyan,bold";
          builtin = "fg=cyan,bold";
          function = "fg=cyan,bold";
          command = "fg=cyan,bold";
          precommand = "fg=cyan,underline";
          commandseparator = "none";
          hashed-command = "fg=green,bold";
          path = "fg=214,underline";
          globbing = "fg=063";
          history-expansion = "fg=white,underline";
          single-hyphen-option = "fg=070";
          double-hyphen-option = "fg=070";
          back-quoted-argument = "none";
          single-quoted-argument = "fg=063";
          double-quoted-argument = "fg=063";
          dollar-quoted-argument = "fg=009";
          dollar-double-quoted-argument = "fg=009";
          assign = "none";
        };
      };
      autocd = true;

      initExtra = ''
# =============================================================================
#                               Plugin Overrides
# =============================================================================
# "zsh-users/zsh-history-substring-search"
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey "^[[1;5A" history-substring-search-up
bindkey "^[[1;5B" history-substring-search-down

# "zsh-users/zsh-autosuggestions"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=075'

# "djui/alias-tips"
ZSH_PLUGINS_ALIAS_TIPS_EXCLUDES="(_ ll vi)"
ZSH_PLUGINS_ALIAS_TIPS_FORCE=1

# ZSH_PLUGINS_ALIAS_TIPS_REVEAL=1
ZSH_PLUGINS_ALIAS_TIPS_REVEAL_EXCLUDES="(_ ll vi)"

# =============================================================================
#                                   Options
# =============================================================================
setopt append_history           # Dont overwrite history
setopt auto_list
setopt auto_menu
setopt auto_pushd
setopt extended_history         # Also record time and duration of commands.
setopt hist_expire_dups_first   # Clear duplicates when trimming internal hist.
setopt hist_find_no_dups        # Dont display duplicates during searches.
setopt hist_ignore_dups         # Ignore consecutive duplicates.
setopt hist_ignore_all_dups     # Remember only one unique copy of the command.
setopt hist_reduce_blanks       # Remove superfluous blanks.
setopt hist_save_no_dups        # Omit older commands in favor of newer ones.
setopt hist_ignore_space        # Ignore commands that start with space.
setopt inc_append_history
setopt interactive_comments
setopt no_beep
setopt no_hist_beep
setopt no_list_beep
setopt magic_equal_subst
setopt notify
setopt print_eight_bit
setopt print_exit_value
setopt prompt_subst
setopt pushd_ignore_dups
setopt share_history            # Share history between multiple shells
setopt transient_rprompt
      '';

      zplug = {
        enable = true;
        plugins = [
          { name = "zsh-users/zsh-autosuggestions"; } # Simple plugin installation
          { name = "jeffreytse/zsh-vi-mode"; }
          { name = "djui/alias-tips"; }
          { name = "hlissner/zsh-autopair"; tags = [ defer:2 ]; }
          { name = "zsh-users/zsh-history-substring-search"; tags = [ as:plugin ]; }
          { name = "bric3/nice-exit-code"; }
          { name = "chrissicool/zsh-256color"; }
          { name = "plugins/git"; tags = [ from:oh-my-zsh ]; }

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

      shellAliases = {
        # Node
        nr = "npm run";

        # Docker
        docker = "sudo $(which docker)";

        # .NET
        db = "dotnet build";
        dr = "dotnet run";

        # Terraform
        tfa = "terraform apply";
        tfaa = "terraform apply -auto-approve";
        tfd = "terraform destroy";
        tfda = "terraform destroy -auto-approve";
        tfi = "terraform init";
        tfp = "terraform plan";
        tfr = "terraform refresh";
        tfs = "terraform show";
        tfsl = "terraform state list";
        tfsr = "terraform state remove";
        tft = "terraform taint";
        tfv = "terraform version";

        # Terragrunt
        tga = "terragrunt apply";
        tgaa = "terragrunt apply -auto-approve";
        tgd = "terragrunt destroy";
        tgda = "terragrunt destroy -auto-approve";
        tgi = "terragrunt init";
        tgp = "terragrunt plan";
        tgr = "terragrunt refresh";
        tgs = "terragrunt show";
        tgsl = "terragrunt state list";
        tgsr = "terragrunt state remove";
        tgt = "terragrunt taint";
        tgv = "terragrunt version";

        # Basic
        ls = "ls --color=auto";
        la = "ls -la";
        md = "mkdir -vp";
        dir = "dir --color=auto";
        grep = "grep --color=auto";
        fgrep = "fgrep --color=auto";
        egrep = "egrep --color=auto";
        loc = "scc";
        rmf = "rm -rf";
        gcsmg = "git commit -m";
      };
    };
  };
}
