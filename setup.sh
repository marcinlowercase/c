#!/usr/bin/env bash
set -euo pipefail

echo "==> Starting setup for compositor 'c' on Arch Linux..."

# Ensure the script is run by a standard user with sudo rights, not raw root
if [ "$EUID" -eq 0 ]; then
    echo "ERROR: Do not run this script as root directly. Run it as your regular user (it will ask for sudo when needed)."
    exit 1
fi

# Detect whether wlroots0.20 or wlroots is available in the Arch repos
if pacman -Si wlroots0.20 &>/dev/null; then
    WLR_PKG="wlroots0.20"
else
    WLR_PKG="wlroots"
fi

echo "==> Detected wlroots package: $WLR_PKG"

# 1. Synchronize repos and install all required development packages and utilities
echo "==> Installing utilities, build tools, drivers, and libraries..."
sudo pacman -S --needed --noconfirm \
    base-devel \
    git \
    vim \
    tree \
    gcc \
    make \
    pkgconf \
    mesa \
    vulkan-intel \
    libdrm \
    libinput \
    libxkbcommon \
    pixman \
    wayland \
    wayland-protocols \
    "$WLR_PKG" \
    foot

# 2. Add current user to video and input groups (required for direct TTY / DRM / touch access)
echo "==> Setting up hardware access permissions (video, input)..."
sudo usermod -aG video,input "$USER"

# 3. Test compile the compositor
echo "==> Verifying build..."
if [ -f Makefile ] && [ -f c.c ]; then
    make clean
    make
    echo "==> Build successful! Binary 'c' is ready."
else
    echo "WARNING: Makefile or c.c not found in current directory. Skipping compilation test."
fi

echo ""
echo "=========================================================="
echo " Setup complete!"
echo " Note: If this is the first time you were added to the"
echo " 'input' or 'video' groups, log out and log back in"
echo " once so group permissions take full effect."
echo "=========================================================="
