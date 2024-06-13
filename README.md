# carettt/dotfiles
Hyprland on NixOS with home-manager.

![image](https://github.com/carettt/dotfiles/assets/59672814/10b16d27-1c43-4979-b53d-416aeefb3053)

## Installation
>[!WARNING]
>This is configured for user `caret` and hostname `patch`. The username and hostname are used multiple times across the configuration (may fix). Quick fix is to use `rg` (installed in essentials.nix) to find and replace. Don't forget to use your new hostname when rebuilding with `nixos-rebuild`

```sh
git clone https://github.com/carettt/dotfiles.git
cd dotfiles
sudo nixos-rebuild switch --flake ./#patch
```
After installation, `nh` can be used to rebuild:
>[!IMPORTANT]
>`nh` does not need to be run with sudo (unlike nixos-rebuild), it will ask you for your password when it needs it.
```sh
nh os switch [--update]
nh os boot [--update]
nh os test [--update]
```

## Structure
```
dotfiles
├── flake.lock
├── flake.nix
├── config
│   ├── configuration.nix
│   ├── hardware-configuration.nix
│   └── home.nix
├── modules
│   ├── utils.nix
│   ├── home-manager
│   │   ├── browser.nix
│   │   ├── default.nix
│   │   ├── desktop.nix
│   │   ├── fuzzel.nix
│   │   ├── git.nix
│   │   ├── hyprland.nix
│   │   ├── music.nix
│   │   ├── powermenu.nix
│   │   ├── template.nix
│   │   ├── terminal.nix
│   │   └── waybar.nix
│   └── nixos
│       ├── audio.nix
│       ├── bluetooth.nix
│       ├── config.nu
│       ├── default.nix
│       ├── essentials.nix
│       ├── login.nix
│       ├── networkingTools.nix
│       ├── nvidia.nix
│       ├── shell.nix
│       ├── template.nix
│       └── themes
│           └── rosepine.nix
└── wallpapers
    └── rosepine-wp.png

7 directories, 29 files
```
