{pkgs, ...}: {
  xdg.enable = true;
  gtk = {
    enable = true;
    catppuccin = {
      enable = true;
      accent = "pink";
      size = "standard";
      tweaks = ["rimless"];
    };

    iconTheme = {
      package = pkgs.catppuccin-papirus-folders;
      name = "Papirus";
    };
  };
}
