{
  lib,
  pkgs,
  config,
  inputs,
  ...
}:
with lib; let
  cfg = config.modules.cli.nixvim;
in {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./core
    ./plugins
  ];

  options.modules.cli.nixvim = {enable = mkEnableOption "nixvim";};

  config = mkIf cfg.enable {
    home.packages = with pkgs; [fd shfmt];

    programs = {
      ripgrep.enable = true;
      fzf = {
        enable = true;
        defaultCommand = "fd --type f --color=always";
        defaultOptions = ["-m" "--height 50%" "--border"];
      };

      nixvim = {
        enable = true;
        defaultEditor = true;
        viAlias = true;
        vimAlias = true;
      };
    };
  };
}
