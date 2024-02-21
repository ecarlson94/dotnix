{ pkgs }:

pkgs.writeShellScriptBin "rebuild" ''
  pushd ~/gitrepos/dotnix
  sudo nixos-rebuild switch --flake .#nixos-wsl --impure
  popd
''
