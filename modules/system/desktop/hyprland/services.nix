{
  services = {
    # Wayland
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

    gnome.gnome-keyring.enable = true;

    dbus.enable = true;
  };
}
