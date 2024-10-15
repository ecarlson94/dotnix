{lib, ...}:
with lib; {
  options.user = {
    name = mkOption {
      type = types.str;
      default = "walawren";
      description = "The name to use for the user account";
    };
  };
}
