{
  config,
  lib,
  name,
  ...
}:
with lib; {
  options.isIsoInstaller = mkOption {
    type = types.bool;
    default = false;
    description = "Whether or not the system is a nixos installer";
  };

  config = {
    networking = {
      hostName = name;

      networkmanager.enable = !config.wsl.enable && !config.isIsoInstaller;
      firewall.enable = true;
    };
  };
}
