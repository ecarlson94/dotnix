{pkgs, ...}: {
  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Mocha-Compact-Pink-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = ["pink"];
        tweaks = ["rimless"];
        size = "compact";
        variant = "mocha";
      };
    };

    iconTheme = {
      package = pkgs.catppuccin-papirus-folders;
      name = "Papirus";
    };
  };
}
