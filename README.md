# dotfiles
 
My dotfiles I ike to use.

## Setup
 
Clone the repo and run Stow from the dotfiles directory:
 
```bash
git clone https://github.com/nmbarr/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Run the install script
chmod +x install.sh
./install.sh

# Stow configs
stow -t $HOME */
```

## install.sh

Installs the following on a fresh Linux system (x86_64 and ARM64 supported):

- System packages: `stow`, `gcc`, `make`, `python3`, `unzip`, `ripgrep`, `fd-find`
- [Go](https://go.dev/)
- [uv](https://github.com/astral-sh/uv) (Python package manager)
- [oh-my-posh](https://ohmyposh.dev/)

## Configs
 
### Bash
Standard `.bashrc` with history settings, color aliases, and bash aliases.
 
### Ghostty
Config for the [Ghostty](https://ghostty.org/) terminal emulator. Includes font, theme, opacity, and Sway/Wayland-specific settings.
 
### Neovim
Neovim 0.11 config using [Lazy.nvim](https://github.com/folke/lazy.nvim) for plugin management. Organized under `lua/brick/`. 
 
### Shell
Shell-agnostic aliases in `.shell_aliases`, sourced by both bash and zsh configs. Includes shortcuts for common git commands and directory navigation.
