# Nix configuration

Personal configuration based on [nix-darwin](https://github.com/LnL7/nix-darwin) and [home-manager](https://github.com/nix-community/home-manager).

## Features

* nix-darwin
* home-manager
* Homebrew integration
* Shells
  * Zsh
  * Nushell
  * Starship prompt
* Ghostty terminal
* Git
* Neovim
* Todo...

## Quick Start

### For nix-darwin

```bash
cd /path/to/nix-darwin
nix flake update
darwin-rebuild switch --flake .#<config_name>
```
