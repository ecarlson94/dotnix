{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.modules.git;
in
{
  options.modules.git = { enable = mkEnableOption "git"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.git
    ];

    programs.git = {
      enable = true;
      diff-so-fancy = {
        enable = true;
        pagerOpts = [ "--tabs=4" "-RFX" ];
      };

      userName = "Eric Carlson";
      userEmail = "e.carlson94@gmail.com";

      ignores = [ "Session.vim" "secrets.sh" "secrets.tfvars" "local.tfvars" ];

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

    programs.gh = {
      enable = true;
      gitCredentialHelper.enable = false;

      settings = {
        git_protocol = "ssh";
      };
    };

    programs.ssh = {
      enable = true;
    };
  };
}
