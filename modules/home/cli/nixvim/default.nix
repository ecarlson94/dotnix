{
  config,
  hostConfig,
  inputs,
  lib,
  ...
}:
with lib; let
  cfg = config.cli.nixvim;
in {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./core
    ./plugins
  ];

  options.cli.nixvim = {enable = mkEnableOption "nixvim";};

  config = mkIf cfg.enable {
    programs = {
      ripgrep.enable = true;

      fd = {
        enable = true;
        hidden = true;
        ignores = [
          ".git/"
          "node_modules/"
          "dist"
        ];
      };

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

    home.persistence."/persist${config.home.homeDirectory}" = mkIf hostConfig.system.impermanence.enable {
      directories = [
        ".config/nvim"
        ".config/fd"
        ".local/share/nvim"
      ];
    };
  };
}
