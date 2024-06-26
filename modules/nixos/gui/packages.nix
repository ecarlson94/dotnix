{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    gnome.gnome-calculator
    loupe # Image Viewer
    zoom-us # Conferencing Software
  ];
}
