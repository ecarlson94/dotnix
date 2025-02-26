{
  hostSpec,
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
        "/home/${hostSpec.user.name}/.ssh/${hostSpec.user.name}_ssh_key"
        "/home/${hostSpec.user.name}/.ssh/id_ed25519"
      ];

      keyFile = "/home/${hostSpec.user.name}/.config/sops/age/keys.txt";

      # generate a new key if the key specified above does not exist
      generateKey = true;
    };

    secrets = {
      "private_keys/${hostSpec.user.name}" = {
        path = "/home/${hostSpec.user.name}/.ssh/${hostSpec.user.name}_ssh_key";
      };
    };
  };
}
