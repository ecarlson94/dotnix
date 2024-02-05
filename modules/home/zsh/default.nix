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
      syntaxHighlighting.enable = true;
      autocd = true;

      initExtra = ''
# "zsh-users/zsh-history-substring-search"
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey "^[[1;5A" history-substring-search-up
bindkey "^[[1;5B" history-substring-search-down

# "zsh-users/zsh-syntax-highlighting"
typeset -gA ZSH_HIGHLIGHT_STYLES ZSH_HIGHLIGHT_PATTERNS

ZSH_HIGHLIGHT_STYLES[cursor]=fg=yellow,bold
ZSH_HIGHLIGHT_STYLES[default]=none
ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=green,bold
ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=green,bold
ZSH_HIGHLIGHT_STYLES[alias]=fg=cyan,bold
ZSH_HIGHLIGHT_STYLES[builtin]=fg=cyan,bold
ZSH_HIGHLIGHT_STYLES[function]=fg=cyan,bold
ZSH_HIGHLIGHT_STYLES[command]=fg=white,bold
ZSH_HIGHLIGHT_STYLES[precommand]=fg=white,underline
ZSH_HIGHLIGHT_STYLES[commandseparator]=none
ZSH_HIGHLIGHT_STYLES[hashed-command]=fg=green,bold
ZSH_HIGHLIGHT_STYLES[path]=fg=214,underline
ZSH_HIGHLIGHT_STYLES[globbing]=fg=063
ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=white,underline
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=070
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=070
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=063
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=063
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=009
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=009
ZSH_HIGHLIGHT_STYLES[assign]=none

ZSH_HIGHLIGHT_PATTERNS=('rm -rf *' 'fg=white,bold,bg=red')

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor line)

# "zsh-users/zsh-autosuggestions"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=075'

# "djui/alias-tips"
ZSH_PLUGINS_ALIAS_TIPS_EXCLUDES="(_ ll vi)"
ZSH_PLUGINS_ALIAS_TIPS_FORCE=1

# ZSH_PLUGINS_ALIAS_TIPS_REVEAL=1
ZSH_PLUGINS_ALIAS_TIPS_REVEAL_EXCLUDES="(_ ll vi)"
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
