{ pkgs, ... }:
{
  imports = [
    ./programs.nix
    ./services.nix
  ];

  environment.sessionVariables = {
    # Hint electron apps to use wayland
    NIXOS_OZONE_WL = "1";
  };

  hardware = {
    opengl.enable = true;
    pulseaudio.support32Bit = true;
  };

  xdg = {
    autostart.enable = true;
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-hyprland
      ];
    };
  };

  security = {
    rtkit.enable = true;

    pam.services.swaylock = {
      text = "auth include login";
    };
  };
}
