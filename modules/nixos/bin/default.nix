{
  pkgs,
  target,
  ...
}: {
  environment.systemPackages = [
    (import ../bin/btop.nix {inherit pkgs;})
    (import ../bin/rebuild.nix {inherit pkgs target;})
    (import ../bin/rebuild-remote.nix {inherit pkgs target;})
  ];
}
