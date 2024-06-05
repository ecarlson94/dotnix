{config, ...}: {
  nix.settings.trusted-users = ["root" config.user.name];
}
