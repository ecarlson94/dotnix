{
  pkgs,
  theme,
  ...
}: {
  xdg.enable = true;
  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Mocha-Compact-Pink-Dark";
      package = pkgs.catppuccin-gtk.override {
        inherit (theme) variant;
        accents = ["pink"];
        size = "standard";
        tweaks = ["rimless"];
      };
    };

    iconTheme = {
      package = pkgs.catppuccin-papirus-folders;
      name = "Papirus";
    };
  };
}
