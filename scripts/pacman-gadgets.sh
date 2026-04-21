#!/usr/bin/env bash
set -euo pipefail

source "$PDE/scripts/utils.sh"

RIBYNS_PDE_LOG_INFO=true info "Installing gadget packages..."

sudo pacman -S --needed --noconfirm \
	cmatrix \
	cowsay \
	fortune-mod \
	sl \
	lolcat \
	figlet \
	toilet

RIBYNS_PDE_LOG_INFO=true success "Gadget packages installed"
