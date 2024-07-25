{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.ui.gaming;
in {
  options.ui.gaming = {enable = mkEnableOption "gaming";};

  config = mkIf cfg.enable {
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
      remotePlay.openFirewall = true;
    };

    environment.systemPackages = with pkgs; [
      heroic
      mangohud
      protonup
    ];

    programs.gamemode.enable = true;

    environment.sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATH = "/home/${config.user.name}/.steam/root/compatibilitytools.d";
    };
  };
}
