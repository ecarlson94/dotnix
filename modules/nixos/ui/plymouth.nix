{
  pkgs,
  theme,
  ...
}: {
  boot = {
    plymouth = {
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
