{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.cli;
in {
  imports = [
    ./btop.nix
    ./dircolors.nix
    ./direnv.nix
    ./git.nix
    ./nvim.nix
    ./zellij.nix
    ./zsh
  ];

  options.modules.cli = {enable = mkEnableOption "cli";};

  config = mkIf cfg.enable {
    modules.cli = {
      btop.enable = true;
      dircolors.enable = true;
      direnv.enable = true;
      git.enable = true;
      nvim.enable = true;
      zellij.enable = true;
      zsh.enable = true;
    };
  };
}
