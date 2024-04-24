{
  runCommand,
  alejandra,
  nodePackages,
  ...
}:
runCommand "check-format" {nativeBuildInputs = [alejandra nodePackages.prettier];} ''
  alejandra --check ${./..}
  prettier --check -u ${./..}/**/*
  touch $out
''
