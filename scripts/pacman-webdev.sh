#!/usr/bin/env bash
set -euo pipefail

PDE="${PDE:-$HOME/ribyns-pde}"
source "$PDE/scripts/utils.sh"

RIBYNS_PDE_LOG_INFO=true info "Installing webdev packages..."

"$PDE/scripts/pacman-S.sh" \
	nodejs \
	npm \
	nvm \
	docker \
	docker-compose \
	docker-buildx \
	postgresql

RIBYNS_PDE_LOG_INFO=true success "Webdev packages installed"
