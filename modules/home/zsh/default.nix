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

      initExtra = ''
        bindkey "''${key[Up]}" up-line-or-search
      '';

      zplug = {
        enable = true;
        plugins = [
          { name = "zsh-users/zsh-autosuggestions"; } # Simple plugin installation
          { name = "jeffreytse/zsh-vi-mode"; }
          { name = "djui/alias-tips"; }
          { name = "hlissner/zsh-autopair"; tags = [ defer:2 ]; }
          { name = "zsh-users/zsh-history-substring-search"; tags = [ as:plugin ]; }
          { name = "b4b4r07/zsh-history-ltsv"; }
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
