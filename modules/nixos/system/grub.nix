{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.system.bootloader.grub;
in {
  options.system.bootloader.grub = {enable = mkEnableOption "grub";};

  config = mkIf cfg.enable {
    catppuccin.grub.enable = true;
    boot.loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
      grub = {
        efiSupport = true;
        device = "nodev";
      };
    };
  };
}
