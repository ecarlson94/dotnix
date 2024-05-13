{
  pkgs,
  lib,
  config,
  theme,
  ...
}:
with lib; let
  inherit (builtins) listToAttrs baseNameOf map;
  cfg = config.modules.desktop.nixos.hyprpaper;

  themedWallpaper = wallpaper:
    pkgs.stdenv.mkDerivation rec {
      name = "${theme.name}-${builtins.baseNameOf wallpaper}";
      nativeBuildInputs = [pkgs.lutgen];

      phases = ["buildPhase" "installPhase"];

      buildPhase = ''
        cp ${wallpaper} ./${name}
        lutgen apply -p ${theme.name} ${name} -o themed
      '';

      installPhase = ''
        cp themed/${name} $out
      '';
    };

  wallpapers = lib.filesystem.listFilesRecursive theme.wallpapers;
  themedWallpapers = listToAttrs (map (wallpaper: {
      name = "${baseNameOf wallpaper}";
      value = themedWallpaper wallpaper;
    })
    wallpapers);
  themedDefaultWallpaper = themedWallpapers."${baseNameOf theme.defaultWallpaper}";
in {
  options.modules.desktop.nixos.hyprpaper = {enable = mkEnableOption "hyprpaper";};

  config = mkIf cfg.enable {
    services.hyprpaper = {
      enable = true;

      settings = {
        ipc = "on";
        splash = false;
        splash_offset = 2.0;

        preload = ["${themedDefaultWallpaper}"];

        wallpaper = [
          "DP-3,${themedDefaultWallpaper}"
          "DP-1,${themedDefaultWallpaper}"
        ];
      };
    };
  };
}
