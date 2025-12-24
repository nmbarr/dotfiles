# Brick's dotfiles
This is a collection of configuration files for various software things

# Dotfile management
This project uses [GNU Stow](https://www.gnu.org/software/stow/) to create symlinks from this repository to your $HOME directory.

**NOTE:** GNU Stow is not supported on Windows.

## Install Stow
You need to have [GNU Stow](https://www.gnu.org/software/stow/) installed to manage the dotfiles. Below are instructions for installing Stow on various operating systems.

### Ubuntu/Debian
```bash
sudo apt update
sudo apt install git stow
```

### Arch Linux
```bash
sudo pacman -S git stow
```

### macOS
```bash
brew install git stow
```

## Initial Installation

1. Clone this repository:
```bash
git clone https://github.com/nmbarr/dotfiles.git ~/dotfiles
```

2. Stow the dotfiles:
```bash
cd ~
stow dotfiles
```

3. Reload your shell:
```bash
source ~/.bashrc  # or ~/.zshrc
```

## Updating Dotfiles

When dotfiles have been updated in the repository:

1. Navigate to your dotfiles directory:
```bash
cd ~/dotfiles
```

2. Pull the latest changes:
```bash
git pull
```

3. Restow to update symlinks (if needed):
```bash
cd ~
stow --restow dotfiles
```

4. Reload your shell configuration:
```bash
source ~/.bashrc  # or ~/.zshrc
```