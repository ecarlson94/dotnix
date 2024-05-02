{
  pkgs,
  config,
  ...
}: {
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };

  environment.systemPackages = with pkgs; [
    heroic
    lutron
    mangohud
    protonup
  ];

  programs.gamemode.enable = true;

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATH = "/home/${config.user.name}/.steam/root/compatibilitytools.d";
  };
}
