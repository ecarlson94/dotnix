{ pkgs, target }:

pkgs.writeShellScriptBin "rebuild" ''
  pushd ~/gitrepos/dotnix
  sudo nixos-rebuild switch --flake .#${target}
  popd
''
