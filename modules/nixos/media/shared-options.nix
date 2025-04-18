{lib, ...}: {
  options.media = {
    mediaDir = lib.mkOption {
      type = lib.types.str;
      default = "/data/media";
      description = "Base directory for media files";
    };

    stateDir = lib.mkOption {
      type = lib.types.str;
      default = "/data/state";
      description = "Base directory for application state";
    };
  };
}
