#!/bin/bash

set -e

REPO_DEST="$HOME/neovim"

STABLE=false
for arg in "$@"; do
	if [[ "$arg" == "--stable" ]]; then
		STABLE=true
	fi
done

if $STABLE; then
	echo "Using branch: stable"
else
	echo "Using branch: master"
fi

if [ -f /etc/arch-release ]; then
	echo "Detected Arch Linux. Installing dependencies..."
	sudo pacman -S --noconfirm --needed base-devel cmake unzip ninja curl
elif [ -f /etc/fedora-release ]; then
	echo "Detected Fedora. Installing dependencies..."
	sudo dnf -y install ninja-build cmake gcc make unzip gettext curl
else
	echo "Unsupported distribution for automatic prerequisite installation."
	echo "Please ensure build tools are installed manually."
	exit 1
fi

if [ -d "$REPO_DEST" ]; then
	echo "Directory exists. Updating repository..."
	cd "$REPO_DEST" || exit 1

	if $STABLE; then
		git checkout stable
		git pull origin stable
	else
		git checkout master
		git pull origin master
	fi

else
	echo "Cloning Neovim repository..."
	git clone --depth 1 --no-single-branch "https://github.com/neovim/neovim" "$REPO_DEST"

	cd "$REPO_DEST" || exit 1

	if $STABLE; then
		git checkout stable
	else
		git checkout master
	fi
fi

echo "Starting build process..."
make clean
make CMAKE_BUILD_TYPE=RelWithDebInfo

echo "Installing Neovim..."
sudo make install

echo "Neovim installation complete."
