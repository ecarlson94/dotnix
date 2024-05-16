{
  lib,
  pkgs,
  config,
  nvim,
  ...
}:
with lib; let
  cfg = config.modules.cli.nvim;
in {
  options.modules.cli.nvim = {enable = mkEnableOption "nvim";};

  config = mkIf cfg.enable {
    home.packages = with pkgs; [nvim fd shfmt];

    programs = {
      ripgrep.enable = true;
      fzf = {
        enable = true;
        defaultCommand = "fd --type f --color=always";
        defaultOptions = ["-m" "--height 50%" "--border"];
      };

      zsh.shellAliases = {
        vi = "nvim";
        vim = "nvim";
        vimdiff = "nvim -d";
      };
    };
  };
}
