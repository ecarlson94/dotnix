{
  config,
  lib,
  theme,
  ...
}:
with lib;
with builtins; let
  cfg = config.modules.ui.nixos.mako;
in {
  options.modules.ui.nixos.mako = {enable = mkEnableOption "mako";};

  config = mkIf cfg.enable {
    services.mako = {
      enable = true;
      catppuccin.enable = true;
      anchor = "bottom-right";
      width = 400;
      height = 300;
      borderRadius = theme.radius;
      defaultTimeout = 10000; # 10s
    };
  };
}
