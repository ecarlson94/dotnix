{ lib, config, ... }:
with lib;
let
  cfg = config.modules.desktop;
in
{
  imports = [
    ../cli
  ];

  options.modules.desktop = { enable = mkEnableOption "desktop"; };

  config = mkIf cfg.enable {
    modules = {
      cli.enable = true;
    };
  };
}
