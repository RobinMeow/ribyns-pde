#!/usr/bin/env bash
set -euo pipefail

source "$RIBYNS_ENV/scripts/utils.sh"

source "$RIBYNS_ENV/scripts/run_on_distro.sh"

RIBYNS_ENV_LOG_INFO=true info "Installing gadget packages..."

run_on_arch <<'EOF'
	sudo pacman -S --needed --noconfirm \
		cmatrix \
		cowsay \
		fortune-mod \
		sl \
		lolcat \
		figlet \
		toilet
EOF

run_on_fedora <<'EOF'
	sudo dnf install -y \
		cmatrix \
		cowsay \
		fortune-mod \
		sl \
		lolcat \
		figlet \
		toilet
EOF

RIBYNS_ENV_LOG_INFO=true success "Gadget packages installed"
