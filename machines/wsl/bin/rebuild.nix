{ pkgs }:

pkgs.writeShellScriptBin "rebuild" ''
  pushd ~/gitrepos/dotnix
  sudo nixos-rebuild switch --flake .#wsl --impure
  popd
''
