{
  hostConfig,
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
        "/home/${hostConfig.user.name}/.ssh/${hostConfig.user.name}_ssh_key"
      ];

      keyFile = "/home/${hostConfig.user.name}/.config/sops/age/keys.txt";

      # generate a new key if the key specified above does not exist
      generateKey = true;
    };
  };
}
