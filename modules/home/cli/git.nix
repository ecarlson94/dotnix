{
  config,
  hostConfig,
  lib,
  ...
}:
with lib; let
  cfg = config.cli.git;
in {
  options.cli.git = {enable = mkEnableOption "git";};

  config = mkIf cfg.enable {
    programs = {
      git = {
        enable = true;
        diff-so-fancy = {
          enable = true;
          pagerOpts = ["--tabs=4" "-RFX"];
        };

        userName = "Kiri Carlson";
        userEmail = "kiri@walawren.com";

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

        matchBlocks = {
          "git" = {
            host = "github.com gitlab.com";
            identitiesOnly = true;
            identityFile = [
              "/home/${hostConfig.user.name}/.ssh/${hostConfig.user.name}_ssh_key"
            ];
          };
        };
      };
    };

    home.persistence."/persist${config.home.homeDirectory}" = mkIf hostConfig.system.impermanence.enable {
      directories = [
        ".config/git"
        ".config/gh"
      ];
    };
  };
}
