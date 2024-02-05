{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.modules.search;
in {
  options.modules.search = { enable = mkEnableOption "search"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.fd
    ];

    programs.ripgrep.enable = true;
    programs.fzf = {
      enable = true;
      enableBashIntegration = true;
      defaultCommand = "fd --type f --color=always";
      defaultOptions = [ "-m" "--height 50%" "--border" ];
    };
  };
}
