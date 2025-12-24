# Brick's dotfiles
This is a collection of configuration files for various software things

# Dotfile management
This project uses [GNU Stow](https://www.gnu.org/software/stow/) to create symlinks from this repository to your $HOME directory.

NOTE: GNU Stow is not supported on Windows.

# Initial Installation

1. Clone this repository:
```bash
git clone https://github.com/nmbarr/dotfiles.git ~/dotfiles (or clone via SSH)
cd ~/dotfiles
```

2. Stow all of the configurations:
```bash
# Stow all dotfiles
stow .
```

3. Reload your shell:
```bash
source ~/.bashrc  # or ~/.zshrc
```

# Updating you local dotfiles

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
stow --restow .
```

4. Reload your shell configuration:
```bash
source ~/.bashrc  # or ~/.zshrc
```