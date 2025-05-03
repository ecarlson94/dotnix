{
  config,
  hostName,
  ...
}: {
  config = {
    networking = {
      inherit hostName;

      networkmanager.enable = !config.wsl.enable;
      firewall.enable = true;
    };
  };
}
