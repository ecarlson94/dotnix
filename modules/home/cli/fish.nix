{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.cli.fish;
in {
  options.modules.cli.fish = {enable = mkEnableOption "fish";};
  config = mkIf cfg.enable {
    programs = {
      dircolors.enableFishIntegration = true;
      fzf.enableFishIntegration = true;
      kitty.shellIntegration.enableFishIntegration = true;

      fish = {
        enable = true;
        catppuccin.enable = true;

        interactiveShellInit = ''
          set fish_greeting # Disable greeting
          set hydro_color_pwd $fish_color_cwd
          set hydro_color_git $fish_color_host
          set hydro_color_prompt $fish_color_host_remote
        '';

        shellAbbrs = {
          # Git
          ga = "git add";
          gaa = "git add --all";
          gb = "git branch";
          gbD = "git branch -D";
          gco = "git checkout";
          gcm = "git checkout $(git branch -l main master --format '%(refname:short)')";
          gcmsg = "git commit -m";
          "gcn!" = "git commit --verbose --amend --no-edit";
          "gcan!" = "git commit --verbose --all --amend --no-edit";
          gd = "git diff";
          gdca = "git diff --cached";
          gf = "git fetch";
          gp = "git push";
          ggp = "git push origin $(git branch --show-current)";
          gl = "git pull";
          ggl = "git pull origin $(git branch --show-current)";
          gr = "git reset";
          "gr!" = "git reset --hard HEAD~";
          "gro!" = "git reset --hard origin/$(git branch --show-current)";
          grs = "git reset --soft HEAD~";
          gst = "git status";
          gsta = "git stash push";
          gstp = "git stash pop";
          gstc = "git stash clear";

          # Docker
          docker = "sudo docker";

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

          # Pulumi
          pl = "pulumi login";
          pu = "pulumi up";

          # Nix Helper
          nhr = "nh os switch";
          nhb = "nh os boot";
          nht = "nh os test";
          nhs = "nh search";
          nhc = "nh clean all --keep 10 --keep-since 10d";

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

          # Zellij
          zd = "zellij da -y";
          zn = "zellij";
        };

        plugins = with pkgs; [
          {
            name = "hydro";
            inherit (fishPlugins.hydro) src;
          }
          {
            name = "autopair";
            inherit (fishPlugins.autopair) src;
          }
        ];
      };
    };
  };
}
