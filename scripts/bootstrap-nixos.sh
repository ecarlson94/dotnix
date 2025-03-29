#!/usr/bin/env bash
set -euo pipefail

# Helpers library
# shellcheck disable=SC1091
source "$(dirname "${BASH_SOURCE[0]}")/helpers.sh"

# User variables
target_hostname=""
target_destination=""
target_user=${BOOTSTRAP_USER-$(whoami)} # Set BOOTSTRAP_ defaults in your shell.nix
ssh_port=${BOOTSTRAP_SSH_PORT-22}
ssh_key=${BOOTSTRAP_SSH_KEY-}
persist_dir="/persist"
nix_src_path="gitrepos" # path relative to /home/${target_user} where nix-config and nix-secrets are written in the users home
git_root=$(git rev-parse --show-toplevel)
nix_secrets_dir=${NIX_SECRETS_DIR:-"${git_root}"/../dotnix}
nix_secrets_yaml="${nix_secrets_dir}/secrets.yaml"

# Create a temp directory for generated host keys
temp=$(mktemp -d)

# Cleanup temporary directory on exit
function cleanup() {
  rm -rf "$temp"
}
trap cleanup exit

# Copy data to the target machine
function sync() {
  # $1 = user, $2 = source, $3 = destination
  rsync -av --filter=':- .gitignore' -e "ssh -oControlMaster=no -l $1 -oport=${ssh_port}" "$2" "$1@${target_destination}:${nix_src_path}"
}

# Usage function
function help_and_exit() {
  echo
  echo "Remotely installs NixOS on a target machine using this dotnix."
  echo
  echo "USAGE: $0 -n <target_hostname> -d <target_destination> -k <ssh_key> [OPTIONS]"
  echo
  echo "ARGS:"
  echo "  -n <target_hostname>                    specify target_hostname of the target host to deploy the nixos config on."
  echo "  -d <target_destination>                 specify ip or domain to the target host."
  echo "  -k <ssh_key>                            specify the full path to the ssh_key you'll use for remote access to the"
  echo "                                          target during install process."
  echo "                                          Example: -k /home/${target_user}/.ssh/my_ssh_key"
  echo
  echo "OPTIONS:"
  echo "  -u <target_user>                        specify target_user with sudo access. dotnix will be cloned to their home."
  echo "                                          Default='${target_user}'."
  echo "  --port <ssh_port>                       specify the ssh port to use for remote access. Default=${ssh_port}."
  echo "  --debug                                 Enable debug mode."
  echo "  -h | --help                             Print this help."
  exit 0
}

# Handle command-line arguments
while [[ $# -gt 0 ]]; do
  case "$1" in
    -n)
      shift
      target_hostname=$1
      ;;
    -d)
      shift
      target_destination=$1
      ;;
    -u)
      shift
      target_user=$1
      ;;
    -k)
      shift
      ssh_key=$1
      ;;
    --port)
      shift
      ssh_port=$1
      ;;
    --debug)
      set -x
      ;;
    -h | --help) help_and_exit ;;
    *)
      red "ERROR: Invalid option detected."
      help_and_exit
      ;;
  esac
  shift
done

if [ -z "$target_hostname" ] || [ -z "$target_destination" ] || [ -z "$ssh_key" ]; then
  red "ERROR: -n, -d, and -k are all required"
  echo
  help_and_exit
fi

# SSH commands
ssh_cmd="ssh \
        -oControlPath=none \
        -oport=${ssh_port} \
        -oForwardAgent=yes \
        -oStrictHostKeyChecking=no \
        -oUserKnownHostsFile=/dev/null \
        -i $ssh_key \
        -t $target_user@$target_destination"
# shellcheck disable=SC2001
ssh_root_cmd=$(echo "$ssh_cmd" | sed "s|${target_user}@|root@|") # uses @ in the sed switch to avoid it triggering on the $ssh_key value
scp_cmd="scp -oControlPath=none -oport=${ssh_port} -oStrictHostKeyChecking=no -i $ssh_key"

git_root=$(git rev-parse --show-toplevel)

# Setup minimal environment for nixos-anywhere and run it
generated_hardware_config=0
function nixos_anywhere() {
  # Clear the known keys, since they should be newly generated for the iso
  green "Wiping known_hosts of $target_destination"
  sed -i "/$target_hostname/d; /$target_destination/d" ~/.ssh/known_hosts

  green "Installing NixOS on remote host $target_hostname at $target_destination"

  ###
  # nixos-anywhere extra-files generation
  ###
  green "Preparing a new ssh_host_ed25519_key pair for $target_hostname."
  # Create the directory where sshd expects to find the host keys
  install -d -m755 "$temp/$persist_dir/etc/ssh"

  # Generate host ssh key pair without a passphrase
  ssh-keygen -t ed25519 -f "$temp/$persist_dir/etc/ssh/ssh_host_ed25519_key" -C "$target_user"@"$target_hostname" -N ""

  # Set the correct permissions so sshd will accept the key
  chmod 600 "$temp/$persist_dir/etc/ssh/ssh_host_ed25519_key"

  green "Adding ssh host fingerprint at $target_destination to ~/.ssh/known_hosts"
  # This will fail if we already know the host, but that's fine
  ssh-keyscan -p "$ssh_port" "$target_destination" | grep -v '^#' >>~/.ssh/known_hosts || true

  ###
  # nixos-anywhere installation
  ###
  cd nixos-bootstrapper
  # If you are rebuilding a machine without any hardware changes, this is likely unneeded or even possibly disruptive
  if no_or_yes "Generate a new hardware config for this host? Yes if your dotnix doesn't have an entry for this host."; then
    green "Generating hardware-configuration.nix on $target_hostname and adding it to the local dotnix."
    $ssh_root_cmd "nixos-generate-config --no-filesystems --root /mnt"
    $scp_cmd root@"$target_destination":/mnt/etc/nixos/hardware-configuration.nix \
      "${git_root}"/hosts/hardware/nixos-"$target_hostname".nix
    generated_hardware_config=1
  fi

  # --extra-files here picks up the ssh host key we generated earlier and puts it onto the target machine
  SHELL=/bin/sh nix run github:nix-community/nixos-anywhere -- \
    --ssh-port "$ssh_port" \
    --post-kexec-ssh-port "$ssh_port" \
    --extra-files "$temp" \
    --flake .#"$target_hostname" \
    root@"$target_destination"

  if ! yes_or_no "Has your system restarted and are you ready to continue? (no exits)"; then
    exit 0
  fi

  green "Adding $target_destination's ssh host fingerprint to ~/.ssh/known_hosts"
  ssh-keyscan -p "$ssh_port" "$target_destination" | grep -v '^#' >>~/.ssh/known_hosts || true

  if [ -n "$persist_dir" ]; then
    $ssh_root_cmd "cp /etc/machine-id $persist_dir/etc/machine-id || true"
    $ssh_root_cmd "cp -R /etc/ssh/ $persist_dir/etc/ssh/ || true"
  fi
  cd - >/dev/null
}

function sops_generate_host_age_key() {
  green "Generating an age key based on the new ssh_host_ed25519_key"

  # Get the SSH key
  target_key=$(ssh-keyscan -p "$ssh_port" -t ssh-ed25519 "$target_destination" 2>&1 | grep ssh-ed25519 | cut -f2- -d" ") || {
    red "Failed to get ssh key. Host down or maybe SSH port now changed?"
    exit 1
  }

  host_age_key=$(echo "$target_key" | ssh-to-age)

  if grep -qv '^age1' <<<"$host_age_key"; then
    red "The result from generated age key does not match the expected format."
    yellow "Result: $host_age_key"
    yellow "Expected format: age10000000000000000000000000000000000000000000000000000000000"
    exit 1
  fi

  green "Updating ./.sops.yaml"
  sops_update_age_key "hosts" "$target_hostname" "$host_age_key"
}

# Validate required options
# FIXME(bootstrap): The ssh key and destination aren't required if only rekeying, so could be moved into specific sections?
if [ -z "${target_hostname}" ] || [ -z "${target_destination}" ] || [ -z "${ssh_key}" ]; then
  red "ERROR: -n, -d, and -k are all required"
  echo
  help_and_exit
fi

if yes_or_no "Run nixos-anywhere installation?"; then
  nixos_anywhere
fi

if yes_or_no "Generate host (ssh-based) age key?"; then
  sops_generate_host_age_key

  # If the age generation commands added previously unseen keys (and associated anchors) we want to add those
  # to some creation rules, namely <host>.yaml and shared.yaml
  sops_add_creation_rule "${target_hostname}"
  # Since we may update the sops.yaml file twice above, only rekey once at the end
  green "Save new keys in repository"
  sops updatekeys -y $nix_secrets_yaml
  nix fmt
  git add -u && (git commit -nm "chore: rekey" || true) && git push
fi

if yes_or_no "Do you want to copy your full dotnix to $target_hostname?"; then
  green "Adding ssh host fingerprint at $target_destination to ~/.ssh/known_hosts"
  ssh-keyscan -p "$ssh_port" "$target_destination" 2>/dev/null | grep -v '^#' >>~/.ssh/known_hosts || true
  green "Copying full dotnix to $target_hostname"
  sync "$target_user" $git_root

  if [ -n "$persist_dir" ]; then
    $ssh_root_cmd "rm /etc/machine-id || true"
    $ssh_root_cmd "rm /etc/ssh/ssh_host_ed25519_key || true"
    $ssh_root_cmd "rm /etc/ssh/ssh_host_ed25519_key.pub || true"
  fi

  # FIXME(bootstrap): Add some sort of key access from the target to download the config (if it's a cloud system)
  if yes_or_no "Do you want to rebuild immediately?"; then
    green "Rebuilding dotnix on $target_hostname"
    $ssh_cmd "cd ${nix_src_path}/dotnix && sudo nixos-rebuild --show-trace --flake .#$target_hostname switch"
  fi
else
  echo
  green "NixOS was successfully installed!"
  echo "Post-install config build instructions:"
  echo "To copy dotnix from this machine to the $target_hostname, run the following commands:"
  echo "ssh-keyscan -p "$ssh_port" "$target_destination" 2>/dev/null | grep -v '^#' >>~/.ssh/known_hosts || true"
  echo "sync \"$target_user\" \"${nix_secrets_dir}\""
  echo "sync \"$target_user\" \"${git_root}\"/../dotnix"
  echo
  echo
  echo "To rebuild, sign into $target_hostname and run the following commands:"
  echo "cd dotnix"
  echo "sudo nixos-rebuild --show-trace --flake .#$target_hostname switch"
  echo
fi

if [[ $generated_hardware_config == 1 ]]; then
  if yes_or_no "Do you want to commit and push the generated hardware-configuration.nix for $target_hostname to dotnix?"; then
    (pre-commit run --all-files 2>/dev/null || true) &&
      git add "$git_root/hosts/hardware/nixos-$target_hostname.nix" &&
      (git commit -m "feat: hardware-configuration.nix for $target_hostname" || true) &&
      git push
  fi
fi

green "Success!"
