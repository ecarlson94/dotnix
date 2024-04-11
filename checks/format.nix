{
  runCommand,
  alejandra,
  ...
}:
runCommand "check-format" {nativeBuildInputs = [alejandra];} ''
  alejandra --check ${./..}
  touch $out
''
