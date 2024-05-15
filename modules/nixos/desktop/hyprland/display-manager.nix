{
  pkgs,
  lib,
  theme,
  ...
}: {
  environment.systemPackages = [
    (
      import ./catppuccin-sddm.nix {
        inherit (pkgs) stdenv just fetchFromGitHub;
        inherit lib;
        inherit (theme) font;
        flavor = theme.variant;
        fontSize = "${builtins.toString theme.fontSize}";
        background = "${theme.defaultWallpaper}";
        loginBackground = true;
      }
    )
  ];

  services.xserver.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = theme.name;
  };
}
