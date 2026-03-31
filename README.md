# dotfiles
 
My dotfiles I ike to use.

## Setup
 
Clone the repo and run Stow from the dotfiles directory:
 
```bash
git clone https://github.com/nmbarr/dotfiles.git ~/dotfiles
cd ~/dotfiles
stow -t $HOME bash ghostty nvim shell
```
 
## Configs
 
### Bash
Standard `.bashrc` with history settings, color aliases, and bash completion.
 
### Ghostty
Config for the [Ghostty](https://ghostty.org/) terminal emulator. Includes font, theme, opacity, and Sway/Wayland-specific settings.
 
### Neovim
Neovim 0.11 config using [Lazy.nvim](https://github.com/folke/lazy.nvim) for plugin management. Organized under `lua/brick/`. 
 
### Shell
Shell-agnostic aliases in `.shell_aliases`, sourced by both bash and zsh configs. Includes shortcuts for common git commands and directory navigation.
 
