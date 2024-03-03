{ pkgs, target }:

pkgs.writeShellScriptBin "rebuild-remote" ''
  sudo nixos-rebuild switch --flake github:ecarlson94/dotnix/main#${target}
''
