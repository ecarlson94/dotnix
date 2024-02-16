{ runCommand
, statix
, ...
}:
runCommand "check-nixpkgs-fmt" { nativeBuildInputs = [ statix ]; } ''
  statix check ${./..}
  touch $out
''
