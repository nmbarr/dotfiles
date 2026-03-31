#!/bin/bash

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

# System packages
sudo apt update && sudo apt install -y \
    stow \
    gcc \
    make \
    python3 \
    unzip \
    ripgrep \
    fd-find

# Go
GO_VERSION="1.24.1"
curl -OL https://go.dev/dl/go${GO_VERSION}.linux-${GO_ARCH}.tar.gz
sudo tar -C /usr/local -xzf go${GO_VERSION}.linux-${GO_ARCH}.tar.gz
rm go${GO_VERSION}.linux-${GO_ARCH}.tar.gz

# uv (installer handles arch automatically)
curl -LsSf https://astral.sh/uv/install.sh | sh

# oh-my-posh
curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ~/.local/bin
