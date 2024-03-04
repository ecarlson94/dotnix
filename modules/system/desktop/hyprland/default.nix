{ pkgs, ... }:
{
  imports = [
    ./services.nix
  ];

  environment.systemPackages = with pkgs; [
    mako # notification daemon
    libnotify # mako depends on this
  ];

  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
  };

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
