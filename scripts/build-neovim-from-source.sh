#!/bin/bash

set -e

source "$PDE/scripts/utils.sh"
REPO_DEST="$HOME/neovim"

STABLE=false
UPDATE=false
for arg in "$@"; do
	if [[ "$arg" == "--stable" ]]; then
		STABLE=true
	elif [[ "$arg" == "--update" ]]; then
		UPDATE=true
	fi
done

BRANCH="master"
if $STABLE; then
	BRANCH="stable"
fi

verbose "Using branch: $BRANCH"

source "$PDE/scripts/dispatch-distro.sh"

dispatch_arch <<'EOF'
	verbose "Detected Arch Linux. Installing dependencies..."
	sudo pacman -S --noconfirm --needed base-devel cmake unzip ninja curl
EOF

dispatch_fedora <<'EOF'
	verbose "Detected Fedora. Installing dependencies..."
	sudo dnf -y install ninja-build cmake gcc make unzip gettext curl
EOF

function build_nvim() {
	verbose "Starting build process..."
	make CMAKE_BUILD_TYPE=RelWithDebInfo

	verbose "Installing Neovim..."
	sudo make install
}

if [ -d "$REPO_DEST" ]; then
	cd "$REPO_DEST" || exit 1

	if $UPDATE; then
		verbose "Updating repository..."
		git fetch --depth 1 origin $BRANCH
		git checkout "$BRANCH"
	else
		verbose "Directory exists. Skipping update (use --update to pull latest changes)."
		git checkout "$BRANCH"
	fi
else
	verbose "Cloning Neovim repository..."
	git clone --depth 1 --no-single-branch "https://github.com/neovim/neovim" "$REPO_DEST"
	cd "$REPO_DEST" || exit 1
	git checkout "$BRANCH"
fi

build_nvim

success "Neovim installation complete."
