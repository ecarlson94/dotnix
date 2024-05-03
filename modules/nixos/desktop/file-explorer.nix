{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    xfce.thunar
    gvfs
  ];
}
