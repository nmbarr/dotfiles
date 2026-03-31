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
 
## Dependencies
 
- [GNU Stow](https://www.gnu.org/software/stow/) — `sudo apt install stow`
- [Neovim 0.11+](https://github.com/neovim/neovim) — installed via ARM64 tarball
- [Oh My Posh](https://ohmyposh.dev/) — `curl -s https://ohmyposh.dev/install.sh | bash -s`
- [Ghostty](https://ghostty.org/) — terminal emulator
- [wl-clipboard](https://github.com/bugaevc/wl-clipboard) — Wayland clipboard support for Neovim (`sudo apt install wl-clipboard`)
- A [Nerd Font](https://www.nerdfonts.com/) — Ghostty has several built in
