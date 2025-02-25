{
  config,
  inputs,
  ...
}: {
  imports = [inputs.sops-nix.homeManagerModules.sops];

  sops = {
    defaultSopsFile = ../../secrets.yaml;
    validateSopsFiles = false;

    age = {
      # automatcally import host SSH keys as age keys
      sshKeyPaths = [
        "/home/${config.user.name}/.ssh/${config.user.name}_ssh_key"
        "/home/${config.user.name}/.ssh/id_ed25519"
      ];

      keyFile = "/home/${config.user.name}/.config/sops/age/keys.txt";

      # generate a new key if the key specified above does not exist
      generateKey = true;
    };

    secrets = {
      "private_keys/${config.user.name}" = {
        path = "/home/${config.user.name}/.ssh/${config.user.name}_ssh_key";
      };
    };
  };
}
