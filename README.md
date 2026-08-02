# dotfiles
 
My dotfiles I like to use.

## Setup
 
Clone the repo and run the install script from the dotfiles directory. It installs tools and stows all configs for you:
 
```bash
git clone https://github.com/nmbarr/dotfiles.git ~/dotfiles
cd ~/dotfiles

chmod +x install.sh
./install.sh
```

## install.sh

Detects the platform (WSL, native Windows, or Linux) and architecture (x86_64 or ARM64), then installs accordingly.

On native Windows (Git Bash/MSYS/Cygwin), it only stows the `windows_terminal` config and exits.

On Linux/WSL it installs:

- System packages (via `scripts/packages.sh`): `stow`, `gcc`, `make`, `python3`, `unzip`, `ripgrep`, `fd-find`, `eza`, `tree`, `hexyl`, `cmake`, `ninja-build`, `gcc-arm-none-eabi`
- A clipboard provider (`wl-clipboard` on Wayland, `xclip` on X11, both if the display server can't be detected)
- [Go](https://go.dev/)
- [Neovim](https://neovim.io/)
- [uv](https://github.com/astral-sh/uv) (Python package manager)
- [oh-my-posh](https://ohmyposh.dev/)
- [Rust](https://www.rust-lang.org/)

It then stows `bash shell nvim ohmyposh templates` (plus `ghostty` outside of WSL).

## Configs
 
### Bash
Standard `.bashrc` with history settings, color aliases, and bash aliases.

### Ghostty
Config for the [Ghostty](https://ghostty.org/) terminal emulator. Includes font, theme, opacity, and Sway/Wayland-specific settings.
 
### Neovim
Neovim 0.11 config using [Lazy.nvim](https://github.com/folke/lazy.nvim) for plugin management. Organized under `lua/brick/`. 
 
### Shell
Shell-agnostic aliases in `.shell_aliases`, sourced by both bash and zsh configs. Includes shortcuts for common git commands and directory navigation.

### oh-my-posh
[oh-my-posh](https://ohmyposh.dev/) prompt theme (`catppuccin.omp.json`).

### Templates
Template files, e.g. `.user_functions.template` for local, git-ignored shell function overrides.

### Windows Terminal
`settings.json` for Windows Terminal, stowed on native Windows only.
