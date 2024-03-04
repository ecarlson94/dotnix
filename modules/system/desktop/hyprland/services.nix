{
  services = {
    xserver = {
      enable = true;
      videoDrivers = [ "amdgpu" ];
      displayManager.gdm = {
        enable = true;
        wayland = true;
      };

      # Configure keymap in X11
      xkb = {
        layout = "us";
        variant = "";
      };
    };

    pipewire = {
      enable = true;

      pulse.enable = true;
      jack.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
    };

    gnome.gnome-keyring.enable = true;

    dbus.enable = true;
  };
}
