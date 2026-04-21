#!/usr/bin/env bash
set -euo pipefail

PDE="${PDE:-$HOME/ribyns-pde}"
source "$PDE/scripts/utils.sh"

RIBYNS_PDE_LOG_INFO=true info "Installing gadget packages..."

"$PDE/scripts/pacman-S.sh" \
	cmatrix \
	cowsay \
	fortune-mod \
	sl \
	lolcat \
	figlet \
	toilet

RIBYNS_PDE_LOG_INFO=true success "Gadget packages installed"
