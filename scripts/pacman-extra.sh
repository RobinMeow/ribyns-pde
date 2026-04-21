#!/usr/bin/env bash
set -euo pipefail

PDE="${PDE:-$HOME/ribyns-pde}"
source "$PDE/scripts/utils.sh"

RIBYNS_PDE_LOG_INFO=true info "Installing extra tool packages..."

"$PDE/scripts/pacman-S.sh" \
	vlc \
	vlc-plugins-all \
	lnav \
	tree \
	btop \
	translate-shell \
	tokei \
	flameshot \
	gemini-cli

RIBYNS_PDE_LOG_INFO=true success "Extra tool packages installed"
