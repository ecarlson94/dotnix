<h1 align="center">
  <img src="./.github/assets/flake.webp" width="250px"/>
  <br>
  ecarlson94's NixOS, HomeManager, and Nixvim Flake
  <a href='#'><img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/palette/macchiato.png" width="600px"/></a>
  <br>
  <div>
    <a href="https://github.com/ecarlson94/dotnix/issues">
        <img src="https://img.shields.io/github/issues/ecarlson94/dotnix?color=f5a97f&labelColor=303446&style=for-the-badge">
    </a>
    <a href="https://github.com/ecarlson94/dotnix/stargazers">
        <img src="https://img.shields.io/github/stars/ecarlson94/dotnix?color=c6a0f6&labelColor=303446&style=for-the-badge">
    </a>
    <a href="https://github.com/ecarlson94/dotnix">
        <img src="https://img.shields.io/github/repo-size/ecarlson94/dotnix?color=ea999c&labelColor=303446&style=for-the-badge">
    </a>
    <a href="https://github.com/ecarlson94/dotnix/blob/main/LICENSE">
        <img src="https://img.shields.io/static/v1.svg?style=for-the-badge&label=License&message=GPL-3&logoColor=ca9ee6&colorA=313244&colorB=a6da95"/>
    </a>
    <a href="https://nixos.org">
        <img src="https://img.shields.io/badge/NixOS-unstable-blue.svg?style=for-the-badge&labelColor=303446&logo=NixOS&logoColor=white&color=91D7E3">
    </a>
  </div>
  <a href="https://builtwithnix.org">
      <img src="https://builtwithnix.org/badge.svg"/>
  </a>
</h1>

## Hosts

### Prequisites

- [Flakes](https://nixos-and-flakes.thiscute.world/nixos-with-flakes/nixos-with-flakes-enabled) enabled

### [NixOS WSL](https://github.com/nix-community/NixOS-WSL)

#### Installing

1. Run the following command:
   ```sh
   sudo nixos-rebuild switch --flake github:ecarlson94/dotnix/main#nixos-wsl
   ```

### [NixOS Desktop](https://nixos.org/download)

#### Installing

1. Run the following command:
   ```sh
   sudo nixos-rebuild switch --flake github:ecarlson94/dotnix/main#desktop
   ```

## Rebuilding

Subsequent rebuilds can be accomplished with:
```sh
rebuild-remote
```

If you have the repo installed locally at `~/gitrepos/dotnix`, you can rebuild with the following instead:
```sh
rebuild
```

## System Modules

### CLI

#### [nvim](./modules/system/cli/nvim)

- Nvim Configuration using [Nixvim](https://github.com/nix-community/nixvim)
- Available as a package
- With [flakes enabled](https://nixos-and-flakes.thiscute.world/nixos-with-flakes/nixos-with-flakes-enabled), can be run with:
  ```sh
  nix run github:ecarlson94/dotnix/main#nvim
  ```

### Desktop

#### [Hyprland](./modules/system/desktop/hyprland)

Bare bones installation of the [Hyprland](https://hyprland.org) dynamic tiling Wayland compositor.

This is the starting point for configuring a UI.

## [Home Modules](./modules/home)

[Home Manager](https://github.com/nix-community/home-manager) configuration

### CLI

Contains toggleable modules for the following:

- [git](https://git-scm.com/)
- [nvim](#nvim)
- [tmux](https://github.com/tmux/tmux/wiki)
- [zsh](https://www.zsh.org/)

The [cli module](./modules/home/cli) will enable all of the above.

```nix
imports = [ ./modules/home ];

modules.cli.enable = true;
```

### Desktop

Contains GUI based app installations and configurations. Enables [CLI](#cli-1) by default.

Requires [Hyprland](#hyprland) configuration first.

### Special Thanks
- [nekowinston](https://github.com/nekowinston) for the nixppuccin wallpaper
- [redyf](https://github.com/redyf/nixdots) for the bar and some Hyprland configuration
- [sioodmy](https://github.com/sioodmy/dotfiles) for their NixOS and Hyprland configuration and badges
- [IogaMaster](https://github.com/IogaMaster/dotfiles) for the most beautiful catppuccin nix flake, some Hyprland config, and the badges
- [This reddit post](https://reddit.com/r/NixOS/comments/137j18j/comment/ju6h25k) for helping me figure out the bare minimum to get Hyprland running
  - AMD GPU minimum required config [here](./modules/system/desktop/hyprland)
