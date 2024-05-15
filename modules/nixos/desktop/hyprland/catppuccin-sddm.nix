{
  lib,
  stdenv,
  fetchFromGitHub,
  just,
  flavor ? "mocha",
  font ? "Noto Sans",
  fontSize ? "9",
  background ? null,
  loginBackground ? false,
  ...
}:
stdenv.mkDerivation rec {
  pname = "catppuccin-sddm-mine";
  version = "1.0.0";
  src = fetchFromGitHub {
    owner = "catppuccin";
    repo = "sddm";
    rev = "v${version}";
    hash = "sha256-SdpkuonPLgCgajW99AzJaR8uvdCPi4MdIxS5eB+Q9WQ=";
  };

  dontWrapQtApps = true;

  nativeBuildInputs = [
    just
  ];

  buildPhase = ''
    runHook preBuild

    just build

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/share/sddm/themes/"
    cp -r dist/catppuccin-${flavor} "$out/share/sddm/themes/catppuccin-${flavor}"

    configFile=$out/share/sddm/themes/catppuccin-${flavor}/theme.conf

    substituteInPlace $configFile \
      --replace-fail 'Font="Noto Sans"' 'Font="${font}"' \
      --replace-fail 'FontSize=9' 'FontSize=${fontSize}'

    ${lib.optionalString (background != null) ''
      substituteInPlace $configFile \
        --replace-fail 'Background="backgrounds/wall.jpg"' 'Background="${background}"' \
        --replace-fail 'CustomBackground="false"' 'CustomBackground="true"'
    ''}

    ${lib.optionalString loginBackground ''
      substituteInPlace $configFile \
        --replace-fail 'LoginBackground="false"' 'LoginBackground="true"'
    ''}

    metadataFile=$out/share/sddm/themes/catppuccin-${flavor}/metadata.desktop

    substituteInPlace $metadataFile \
      --replace 'QtVersion=6' ""

    runHook postInstall
  '';
}
