## 📦 Hetzner Storage Box Mount Module

This NixOS module mounts Hetzner Storage Boxes using `rclone mount` with production-tuned caching and systemd integration.

### ✅ Features

- 🔐 Pulls SSH keys securely via `sops-nix`
- ⚡ Tuned for remote streaming (Jellyfin, etc.)
- 🧱 Caches aggressively for long-distance performance
- 📂 Supports multiple named boxes
- 🚫 Prevents accidental duplicate mounts (same `host + remotePath`)
- 🧠 Per-client isolation by default via `remotePath = "/${config.networking.hostName}"`

### 📄 Usage

```nix
{
  imports = [ ./modules/nixos/system/hetzner/storagebox.nix ];

  system.hetzner.storagebox.media = {
    enable = true;
    user = "u123456";
    host = "u123456.your-storagebox.de";
    keySecret = "storagebox_key_media";
    mountPoint = "/mnt/media";
    # remotePath defaults to "/${config.networking.hostName}"
  };

  system.hetzner.storagebox.backups = {
    enable = true;
    user = "u123456";
    host = "u123456.your-storagebox.de";
    keySecret = "storagebox_key_media";
    remotePath = "/backups/media";
    mountPoint = "/mnt/backup";
  };
}
```

### 🔒 `sops-nix` Secret Example

```yaml
storagebox_key_media: |
  -----BEGIN OPENSSH PRIVATE KEY-----
  ...
  -----END OPENSSH PRIVATE KEY-----
```

### 📁 Directory Structure

| Remote Path              | Local Mount   | Purpose                 |
| ------------------------ | ------------- | ----------------------- |
| `/media-server-hostname` | `/mnt/media`  | Media files             |
| `/backups/media`         | `/mnt/backup` | Jellyfin metadata, etc. |
