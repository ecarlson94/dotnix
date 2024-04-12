{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.cli;
in {
  imports = [
    ./dircolors.nix
    ./direnv.nix
    ./git.nix
    ./nvim.nix
    ./tmux.nix
    ./zsh
  ];

  options.modules.cli = {enable = mkEnableOption "cli";};

  config = mkIf cfg.enable {
    modules.cli = {
      dircolors.enable = true; # Folder/file colors for ls etc
      direnv.enable = true; # Auto change dev environment on changing directory
      git.enable = true; # Version Control
      nvim.enable = true; # Text editor
      tmux.enable = true; # Terminal Emulator
      zsh.enable = true; # Shell
    };
  };
}
