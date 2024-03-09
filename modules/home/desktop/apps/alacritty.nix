{ lib, config, ... }:
with lib;
let
  cfg = config.modules.desktop.alacritty;
in
{
  options.modules.desktop.alacritty = { enable = mkEnableOption "alacritty"; };

  config = mkIf cfg.enable {
    programs.alacritty = {
      enable = true;
    };
  };
}
