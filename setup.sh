#!/bin/bash

# #################################################################################################
# This setup script was forked from the below github with a few tweaks:
# https://github.com/WizardStark/dotfiles/blob/main/setup.sh
# #################################################################################################

set -e

# Protect against running on Windows (outside WSL)
if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" || "$OSTYPE" == "win32" ]]; then
    echo "ERROR: This script is designed for Linux and macOS only." >&2
    echo "You appear to be running on Windows (Git Bash/Cygwin/MinGW)." >&2
    echo "" >&2
    echo "Options:" >&2
    echo "  1. Use WSL2 (recommended): wsl --install" >&2
    echo "  2. Run this script inside a WSL2 Ubuntu distribution" >&2
    echo "" >&2
    echo "WSL2 provides a full Linux environment on Windows where this script will work." >&2
    exit 1
fi

# Verify we're on a supported OS
if [[ "$OSTYPE" != "linux-gnu"* && "$OSTYPE" != "darwin"* ]]; then
    echo "ERROR: Unsupported operating system: $OSTYPE" >&2
    echo "This script supports Linux and macOS only." >&2
    exit 1
fi

sudo echo "Shell elevated with su permissions"

require() {
    command -v "${1}" &>/dev/null && return 0
    printf 'Missing required application: %s\n' "${1}" >&2
    return 1
}

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # install linuxbrew dependencies
    # these need to be installed with apt to allow installation of brew
    if require apt; then
        sudo apt update
        sudo apt-get install -y build-essential procps curl file git
    elif require yum; then
        sudo yum groupinstall 'Development Tools'
        sudo yum install procps-ng curl file git
    fi
fi

if ! require brew; then
    echo "Attempting to configure Homebrew from standard locations..."
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if [ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
            eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        if [ -f "/opt/homebrew/bin/brew" ]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        elif [ -f "/usr/local/bin/brew" ]; then
            eval "$(/usr/local/bin/brew shellenv)"
        fi
    fi

    if ! require brew; then
        echo "Installing Homebrew..."
        export NONINTERACTIVE=1
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

        if [[ "$OSTYPE" == "linux-gnu"* ]]; then
            if [ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
                eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
            fi
        elif [[ "$OSTYPE" == "darwin"* ]]; then
            if [ -f "/opt/homebrew/bin/brew" ]; then
                eval "$(/opt/homebrew/bin/brew shellenv)"
            elif [ -f "/usr/local/bin/brew" ]; then
                eval "$(/usr/local/bin/brew shellenv)"
            fi
        fi
    fi
fi

# Core essentials
brew install git neovim pnpm stow tmux uv zsh

# Optional enhancements (comment out if you want minimal)
# brew install bat eza ripgrep fd git-delta jq zoxide

pnpm install -g tree-sitter-cli
uv tool install neovim-remote

mkdir -p ~/.config

(
    git clone https://github.com/catppuccin/zsh-syntax-highlighting.git ~/.zsh-catpuccin
)

(
    mkdir -p "$(bat --config-dir)/themes"
    wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Mocha.tmTheme
    bat cache --build
)

(
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --key-bindings --completion --update-rc
)

(
    git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
)

echo "Moving existing ~/.zshrc to ~/.zshrc_old"
mv ~/.zshrc ~/.zshrc_old
stow -v --adopt -t $HOME home

~/.config/tmux/plugins/tpm/bin/install_plugins

nvim --headless "+Lazy! sync" +qa

command -v zsh | sudo tee -a /etc/shells
sudo chsh -s $(which zsh) $(whoami)
zsh -l
echo "Done!"