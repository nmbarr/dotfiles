#!/bin/bash
set -e

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
    cmake \
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
