# dotnix

My [NixOS](https://nixos.org) and [Home Manager](https://github.com/nix-community/home-manager) configurations.

## Hosts

### [NixOS WSL](https://github.com/nix-community/NixOS-WSL)

#### Installing

1. Enable [flakes](https://nixos-and-flakes.thiscute.world/nixos-with-flakes/nixos-with-flakes-enabled)
1. Run the following command:
   ```sh
   sudo nixos-rebuild switch --flake github:ecarlson94/dotnix/main#nixos-wsl --impure
   ```

#### Reubilding

Subsequent rebuilds can be accomplished with:
```sh
rebuild-remote
```

If you have the repo installed locally at `~/gitrepos/dotnix`, you can rebuild with the following instead:
```sh
rebuild
```

## Modules

### [home](./modules/home)

- [Home Manager](https://github.com/nix-community/home-manager) configuration
- No way to configure standalone yet, only works with [NixOS WSL](https://github.com/nix-community/NixOS-WSL)
- Contains toggleable modules for the following:
  - [dircolors](https://man7.org/linux/man-pages/man1/dircolors.1.html)
  - [git](https://git-scm.com/)
  - [nvim](#nvim)
  - [tmux](https://github.com/tmux/tmux/wiki)
  - [zsh](https://www.zsh.org/)
  - headeless-ide
    - A module that when enabled, enable the following modules:
      - dircolors
      - git
      - nvim
      - tmux
      - zsh

### [nvim](./modules/nvim)

- Nvim Configuration using [Nixvim](https://github.com/nix-community/nixvim)
- Available as a package
- With [flakes enabled](https://nixos-and-flakes.thiscute.world/nixos-with-flakes/nixos-with-flakes-enabled), can be run with:
  ```sh
  nix run github:ecarlson94/dotnix/main#nvim
  ```
