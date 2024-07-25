{
  pkgs,
  lib,
  config,
  theme,
  ...
}:
with lib; let
  cfg = config.ui.sddmTheme;
in {
  options.ui.sddmTheme = {enable = mkEnableOption "sddmTheme";};

  config = mkIf cfg.enable {
    environment.systemPackages = [
      (
        pkgs.stdenv.mkDerivation rec {
          pname = "catppuccin-sddm-mine";
          version = "1.0.0";
          src = pkgs.fetchFromGitHub {
            owner = "catppuccin";
            repo = "sddm";
            rev = "v${version}";
            hash = "sha256-SdpkuonPLgCgajW99AzJaR8uvdCPi4MdIxS5eB+Q9WQ=";
          };

          dontWrapQtApps = true;

          nativeBuildInputs = [
            pkgs.just
          ];

          buildPhase = ''
            runHook preBuild

            just build

            runHook postBuild
          '';

          installPhase = ''
            runHook preInstall

            mkdir -p "$out/share/sddm/themes/"
            cp -r dist/catppuccin-${theme.variant} "$out/share/sddm/themes/catppuccin-${theme.variant}"

            configFile=$out/share/sddm/themes/catppuccin-${theme.variant}/theme.conf

            substituteInPlace $configFile \
              --replace-fail 'Font="Noto Sans"' 'Font="${theme.font}"' \
              --replace-fail 'FontSize=9' 'FontSize=${builtins.toString theme.fontSize}'

            substituteInPlace $configFile \
              --replace-fail 'Background="backgrounds/wall.jpg"' 'Background="${theme.defaultWallpaper}"' \
              --replace-fail 'CustomBackground="false"' 'CustomBackground="true"'

            substituteInPlace $configFile \
              --replace-fail 'LoginBackground="false"' 'LoginBackground="true"'

            metadataFile=$out/share/sddm/themes/catppuccin-${theme.variant}/metadata.desktop

            substituteInPlace $metadataFile \
              --replace 'QtVersion=6' ""

            runHook postInstall
          '';
        }
      )
    ];

    services.displayManager.sddm = {
      theme = theme.name;
    };
  };
}
