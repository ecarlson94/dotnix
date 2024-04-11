{pkgs, ...}: {
  home.stateVersion = "23.11";

  imports = [
    ./cli
    ./desktop
  ];

  home = {
    packages = [
      pkgs.curl
      pkgs.wget
    ];
  };
}
