{
  pkgs,
  lib,
  config,
  theme,
  ...
}:
with lib; let
  cfg = config.ui.plymouth;
in {
  options.ui.plymouth = {enable = mkEnableOption "plymouth";};

  config = mkIf cfg.enable {
    boot.plymouth = {
      enable = true;
      font = "${pkgs.jetbrains-mono}/share/fonts/truetype/JetBrainsMono-Regular.ttf";

      themePackages = [
        (pkgs.catppuccin-plymouth.override {
          inherit (theme) variant;
        })
      ];
      theme = theme.name;
    };
  };
}
