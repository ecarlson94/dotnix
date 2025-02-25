{
  config,
  inputs,
  ...
}: {
  imports = [inputs.sops-nix.homeManagerModules.sops];

  sops = {
    age.keyFile = "/home/${config.user.name}/.config/sops/age/keys.txt";

    defaultSopsFile = ../../secrets.yaml;
    validateSopsFiles = false;

    secrets = {
      "private_keys/${config.user.name}" = {
        path = "/home/${config.user.name}/.ssh/${config.user.name}_ssh_key";
      };
    };
  };
}
