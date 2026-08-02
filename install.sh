#!/bin/bash
set -e

# Detect platform: wsl, windows (Git Bash/MSYS/Cygwin), or linux
if [ -n "$WSL_DISTRO_NAME" ] || grep -qi microsoft /proc/version 2>/dev/null; then
    PLATFORM="wsl"
elif [[ "$OSTYPE" == "msys"* || "$OSTYPE" == "cygwin"* ]]; then
    PLATFORM="windows"
else
    PLATFORM="linux"
fi

if [ "$PLATFORM" = "windows" ]; then
    echo "Native Windows detected, only stowing windows_terminal config..."
    cd ~/dotfiles
    stow windows_terminal
    echo "Done!"
    exit 0
fi

# Detect architecture
ARCH=$(uname -m)
if [ "$ARCH" = "x86_64" ]; then
    GO_ARCH="amd64"
    OMP_ARCH="amd64"
elif [ "$ARCH" = "aarch64" ]; then
    GO_ARCH="arm64"
    OMP_ARCH="arm64"
else
    echo "Unsupported architecture: $ARCH"
    exit 1
fi

# Map uname -m to Neovim release filename arch
NVIM_ARCH=$(uname -m)
[ "$NVIM_ARCH" = "aarch64" ] && NVIM_ARCH="arm64"

# System packages
sudo apt update && sudo apt install -y \
    stow \
    gcc \
    make \
    python3 \
    unzip \
    ripgrep \
    fd-find \
    eza \
    tree \
    hexyl \
    ninja-build \
    gcc-arm-none-eabi

# Clipboard provider
if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    echo "Wayland detected, installing wl-clipboard..."
    sudo apt install -y wl-clipboard
elif [ "$XDG_SESSION_TYPE" = "x11" ]; then
    echo "X11 detected, installing xclip..."
    sudo apt install -y xclip
else
    echo "Could not detect display server, installing both..."
    sudo apt install -y wl-clipboard xclip
fi

# Go
GO_VERSION="1.24.1"
curl -OL https://go.dev/dl/go${GO_VERSION}.linux-${GO_ARCH}.tar.gz
sudo tar -C /usr/local -xzf go${GO_VERSION}.linux-${GO_ARCH}.tar.gz
rm go${GO_VERSION}.linux-${GO_ARCH}.tar.gz

# Neovim
NVIM_VERSION="0.11.0"
curl -LO https://github.com/neovim/neovim/releases/download/v${NVIM_VERSION}/nvim-linux-${NVIM_ARCH}.tar.gz
tar -xzf nvim-linux-${NVIM_ARCH}.tar.gz
sudo rm -rf /opt/nvim-linux-${NVIM_ARCH}
sudo mv nvim-linux-${NVIM_ARCH} /opt/nvim-linux-${NVIM_ARCH}
rm nvim-linux-${NVIM_ARCH}.tar.gz

# uv (installer handles arch automatically)
curl -LsSf https://astral.sh/uv/install.sh | sh

# oh-my-posh
curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ~/.local/bin

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
. "$HOME/.cargo/env"

# Stow dotfiles
echo "Stowing dotfiles..."
cd ~/dotfiles
if [ "$PLATFORM" = "wsl" ]; then
    stow bash zsh shell nvim ohmyposh templates
else
    stow bash zsh shell nvim ghostty ohmyposh templates
fi

echo "Done! Open a new shell or run: source ~/.bashrc"
