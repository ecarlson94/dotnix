{pkgs}:
pkgs.writeShellScriptBin "btop" ''
  nix-shell -p btop --command btop
''
