{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    curl
    devbox
    wget
  ];
}
