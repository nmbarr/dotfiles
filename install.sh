#!/bin/bash
set -e

# Downloads a .tar.gz, extracts it, and moves the extracted directory into
# place at $dest (replacing whatever was there before).
download_and_extract() {
    local url="$1"
    local dest="$2"
    local archive
    archive=$(basename "$url")
    local extracted
    extracted=$(basename "$dest")

    echo "Downloading $archive..."
    curl -LO "$url"
    tar -xzf "$archive"
    rm "$archive"

    echo "Installing to $dest..."
    sudo rm -rf "$dest"
    sudo mv "$extracted" "$dest"
}

# Detect platform: wsl, windows (Git Bash/MSYS/Cygwin), or linux
echo "Detecting platform..."
if [ -n "$WSL_DISTRO_NAME" ] || grep -qi microsoft /proc/version 2>/dev/null; then
    PLATFORM="wsl"
elif [[ "$OSTYPE" == "msys"* || "$OSTYPE" == "cygwin"* ]]; then
    PLATFORM="windows"
else
    PLATFORM="linux"
fi
echo "Platform: $PLATFORM"

if [ "$PLATFORM" = "windows" ]; then
    echo "Native Windows detected, only stowing windows_terminal config..."
    cd ~/dotfiles
    stow windows_terminal
    echo "Done!"
    exit 0
fi

# Detect architecture
echo "Detecting architecture..."
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
echo "Architecture: $ARCH"

# Map uname -m to Neovim release filename arch
NVIM_ARCH=$(uname -m)
[ "$NVIM_ARCH" = "aarch64" ] && NVIM_ARCH="arm64"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Installing system packages..."
"$SCRIPT_DIR/scripts/packages.sh"

echo "Installing Go..."
GO_VERSION="1.24.1"
download_and_extract "https://go.dev/dl/go${GO_VERSION}.linux-${GO_ARCH}.tar.gz" "/usr/local/go"

echo "Installing Neovim..."
NVIM_VERSION="0.11.0"
download_and_extract "https://github.com/neovim/neovim/releases/download/v${NVIM_VERSION}/nvim-linux-${NVIM_ARCH}.tar.gz" "/opt/nvim-linux-${NVIM_ARCH}"

echo "Installing uv..."
curl -LsSf https://astral.sh/uv/install.sh | sh

echo "Installing oh-my-posh..."
curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ~/.local/bin

echo "Installing Rust..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
. "$HOME/.cargo/env"

# Stow dotfiles
echo "Stowing dotfiles..."
cd ~/dotfiles
PACKAGES="bash shell nvim ohmyposh"
[ "$PLATFORM" != "wsl" ] && PACKAGES="$PACKAGES ghostty"
if [ -f "$HOME/.user_functions" ]; then
    echo "Existing ~/.user_functions found, skipping templates package"
else
    PACKAGES="$PACKAGES templates"
fi
stow $PACKAGES

echo "Done! Open a new shell or run: source ~/.bashrc"
