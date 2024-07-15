{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    gnome-calculator
    loupe # Image Viewer
    zoom-us # Conferencing Software
  ];
}
