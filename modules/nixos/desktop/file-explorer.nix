{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    xfce.thunar
  ];

  services.gvfs.enable = true;
}
