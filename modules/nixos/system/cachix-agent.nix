{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.system.cachix-agent;
in {
  options.system.cachix-agent = {enable = mkEnableOption "cachix-agent";};

  config = mkIf cfg.enable {
    services.cachix-agent.enable = true;

    sops.secrets.cachix-agent-token = {
      path = "/etc/cachix-agent.token";
    };
  };
}
