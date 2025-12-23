## Bricks's dotfiles

This is a collection of configuration files for the tools that I like to use during software development

## Dotfile management

This project uses [GNU Stow](https://www.gnu.org/software/stow/) to create symlinks
from this repository to your $HOME directory.

## Setup

NOTE:

- This script will ask for sudo permissions, which are then used for brew and apt (if applicable) installs
- This script will create symlinks to ~/.zshrc, ~/.bashrc, etc,
  see [GNU Stow](https://www.gnu.org/software/stow/manual/stow.html#Conflicts) for how conflicts will be handled

```bash
git clone https://github.com/nmbarr/dotfiles.git
cd dotfiles
./setup.sh
```