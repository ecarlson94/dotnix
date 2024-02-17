{ runCommand
, statix
, ...
}:
runCommand "check-statix" { nativeBuildInputs = [ statix ]; } ''
  statix check ${./..}
  touch $out
''
