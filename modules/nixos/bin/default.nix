{
  pkgs,
  target,
  ...
}: {
  environment.systemPackages = [
    (import ../bin/rebuild.nix {inherit pkgs target;})
    (import ../bin/rebuild-remote.nix {inherit pkgs target;})
  ];
}
