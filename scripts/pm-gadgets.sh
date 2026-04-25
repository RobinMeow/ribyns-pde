#!/usr/bin/env bash
set -euo pipefail

source "$PDE/scripts/utils.sh"

source "$PDE/scripts/dispatch-distro.sh"

RIBYNS_PDE_LOG_INFO=true info "Installing gadget packages..."

dispatch_arch <<'EOF'
	sudo pacman -S --needed --noconfirm \
		cmatrix \
		cowsay \
		fortune-mod \
		sl \
		lolcat \
		figlet \
		toilet
EOF

dispatch_fedora <<'EOF'
	sudo dnf install -y \
		cmatrix \
		cowsay \
		fortune-mod \
		sl \
		lolcat \
		figlet \
		toilet
EOF

RIBYNS_PDE_LOG_INFO=true success "Gadget packages installed"
