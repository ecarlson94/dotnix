{
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

      fish = {
        enable = true;
        catppuccin.enable = true;

        shellAbbrs = {
          # Git
          ga = "git add";
          gaa = "git add --all";
          gco = "git checkout";
          gcmsg = "git commit -m";
          "gcn!" = "git commit --verbose --amend --no-edit";
          "gcan!" = "git commit --verbose --all --amend --no-edit";
          gd = "git diff";
          gdca = "git diff --cached";
          gf = "git fetch";
          gp = "git push";
          ggp = "git push origin $(git branch 2>/dev/null | sed -n '/\* /s///p')";
          gl = "git pull";
          ggl = "git pull origin $(git branch 2>/dev/null | sed -n '/\* /s///p')";
          gst = "git status";
          gsta = "git stash push";
          gstp = "git stash pop";
          gstc = "git stash clear";

          # Docker
          docker = "sudo $(sudo which docker)";

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
        };
      };
    };
  };
}
