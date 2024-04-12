{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfg = config.modules.cli.zsh;
in {
  options.modules.cli.zsh = {enable = mkEnableOption "zsh";};

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.zsh
      pkgs.scc
    ];

    programs = {
      zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        autocd = true;

        history = {
          expireDuplicatesFirst = true;
          extended = true;
          ignoreDups = true;
          ignoreAllDups = true;
          ignoreSpace = true;
        };

        historySubstringSearch = {
          enable = true;
        };

        syntaxHighlighting = {
          enable = true;
          highlighters = [
            "main"
            "brackets"
            "pattern"
            "cursor"
            "line"
          ];
        };

        zplug = {
          enable = true;
          plugins = [
            {
              name = "catppuccin/zsh-syntax-highlighting";
              tags = ["use:themes/catppuccin_mocha-zsh-syntax-highlighting"];
            }
            {name = "jeffreytse/zsh-vi-mode";}
            {name = "MichaelAquilina/zsh-you-should-use";}
            {name = "bric3/nice-exit-code";}
            {name = "chrissicool/zsh-256color";}
            {
              name = "plugins/git";
              tags = ["from:oh-my-zsh"];
            }
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

          # OpenTofu
          otfa = "tofu apply";
          otfaa = "tofu apply -auto-approve";
          otfd = "tofu destroy";
          otfda = "tofu destroy -auto-approve";
          otfi = "tofu init";
          otfp = "tofu plan";
          otfr = "tofu refresh";
          otfs = "tofu show";
          otfsl = "tofu state list";
          otfsr = "tofu state remove";
          otft = "tofu taint";
          otfv = "tofu version";

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
          ls = "ls -h --color=auto";
          la = "ls -lah";
          md = "mkdir -vp";
          dir = "dir --color=auto";
          grep = "grep --color=auto";
          fgrep = "fgrep --color=auto";
          egrep = "egrep --color=auto";
          loc = "scc";
          rmf = "rm -rf";
          gcsmg = "git commit -m";
        };

        initExtra = ''
          # =============================================================================
          #                               Plugin Overrides
          # =============================================================================
          YSU_HARDCORE=1

          # =============================================================================
          #                                   Options
          # =============================================================================
          setopt append_history           # Dont overwrite history
          setopt auto_list
          setopt auto_menu
          setopt auto_pushd
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
          setopt transient_rprompt
        '';
      };
    };
  };
}
