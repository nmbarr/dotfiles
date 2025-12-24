#!/bin/bash

# #################################################################################################
# This setup script was forked from the below github with a few tweaks:
# https://github.com/WizardStark/dotfiles/blob/main/setup.sh
# #################################################################################################

BREW_PACKAGES=(
    bat
    git
    neovim
    node
    pnpm
    stow
    tmux
    uv
    zsh
)

APT_DEPENDENCIES=(
    build-essential
    procps
    curl
    file
    git
)

YUM_DEPENDENCIES=(
    procps-ng
    curl
    file
    git
)

PNPM_PACKAGES=(
    tree-sitter-cli
)

UV_TOOLS=(
    neovim-remote
)

declare -A GIT_REPOS=(
    ["~/.zsh-catpuccin"]="https://github.com/catppuccin/zsh-syntax-highlighting.git"
    ["~/.fzf"]="https://github.com/junegunn/fzf.git"
    ["~/.config/tmux/plugins/tpm"]="https://github.com/tmux-plugins/tpm"
)

# Exit immediately if a command exits with a non-zero status
set -e

# Prevent running on Windows (except WSL)
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

# Check for supported OS
if [[ "$OSTYPE" != "linux-gnu"* && "$OSTYPE" != "darwin"* ]]; then
    echo "ERROR: Unsupported operating system: $OSTYPE" >&2
    echo "This script supports Linux and macOS only." >&2
    exit 1
fi

sudo echo "Shell elevated with su permissions"

# Check for valid application PATH
require() {
    command -v "${1}" &>/dev/null && return 0
    printf 'Missing required application: %s\n' "${1}" >&2
    return 1
}

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if require apt; then
        sudo apt update
        sudo apt-get install -y "${APT_DEPENDENCIES[@]}"
    elif require yum; then
        sudo yum groupinstall 'Development Tools'
        sudo yum install "${YUM_DEPENDENCIES[@]}"
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

echo "Installing Homebrew packages..."
brew install "${BREW_PACKAGES[@]}"

echo "Installing pnpm packages..."
for package in "${PNPM_PACKAGES[@]}"; do
    pnpm install -g "$package"
done

echo "Installing uv tools..."
for tool in "${UV_TOOLS[@]}"; do
    uv tool install "$tool"
done

mkdir -p ~/.config

echo "Cloning Git repositories..."
for dest in "${!GIT_REPOS[@]}"; do
    repo="${GIT_REPOS[$dest]}"
    dest_expanded="${dest/#\~/$HOME}"
    
    (
        if [[ "$dest" == *"fzf"* ]]; then
            git clone --depth 1 "$repo" "$dest_expanded"
        else
            git clone "$repo" "$dest_expanded"
        fi
    )
done

(
    echo "Installing bat theme..."
    mkdir -p "$(bat --config-dir)/themes"
    wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Mocha.tmTheme
    bat cache --build
)

echo "Configuring fzf..."
~/.fzf/install --key-bindings --completion --update-rc

echo "Deploying dotfiles..."
if [ -f ~/.zshrc ]; then
    echo "Moving existing ~/.zshrc to ~/.zshrc_old"
    mv ~/.zshrc ~/.zshrc_old
fi
stow -v --adopt -t $HOME home

echo "Installing tmux plugins..."
~/.config/tmux/plugins/tpm/bin/install_plugins

echo "Installing Neovim plugins..."
nvim --headless "+Lazy! sync" +qa

echo "Setting zsh as default shell..."
command -v zsh | sudo tee -a /etc/shells
sudo chsh -s $(which zsh) $(whoami)

echo "Launching zsh..."
zsh -l
echo "Done!"