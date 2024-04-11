{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfg = config.modules.cli.git;
in {
  options.modules.cli.git = {enable = mkEnableOption "git";};

  config = mkIf cfg.enable {
    programs = {
      git = {
        enable = true;
        diff-so-fancy = {
          enable = true;
          pagerOpts = ["--tabs=4" "-RFX"];
        };

        userName = "Eric Carlson";
        userEmail = "e.carlson94@gmail.com";

        ignores = ["Session.vim" "secrets.sh" "secrets.tfvars" "local.tfvars"];

        extraConfig = {
          core = {
            autocrlf = "input";
          };

          init = {
            defaultBranch = "main";
          };

          pull = {
            rebase = false;
          };
        };
      };

      gh = {
        enable = true;
        gitCredentialHelper.enable = false;

        settings = {
          git_protocol = "ssh";
        };
      };

      ssh = {
        enable = true;
      };
    };
  };
}
