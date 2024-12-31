{
  config,
  lib,
  theme,
  ...
}:
with lib;
with builtins; let
  cfg = config.ui.nixos.mako;
in {
  options.ui.nixos.mako = {enable = mkEnableOption "mako";};

  config = mkIf cfg.enable {
    catppuccin.mako.enable = true;

    services.mako = {
      enable = true;
      anchor = "bottom-right";
      width = 400;
      height = 300;
      borderRadius = theme.radius;
      defaultTimeout = 10000; # 10s
    };
  };
}
