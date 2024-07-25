{pkgs, ...}: {
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  services.blueman.enable = true;

  # PS5 DualSense Control
  environment.systemPackages = [pkgs.dualsensectl];
}
