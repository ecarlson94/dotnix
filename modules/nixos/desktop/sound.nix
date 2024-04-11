{pkgs, ...}: {
  sound = {
    enable = true;
    mediaKeys.enable = true;
  };

  environment.systemPackages = with pkgs; [
    pavucontrol # PulseAudio Volume Control
  ];

  programs.noisetorch.enable = true; # Mic Noise Filter

  hardware.pulseaudio.support32Bit = true;

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;

    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
  };
}
