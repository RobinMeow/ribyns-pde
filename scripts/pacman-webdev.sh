#!/usr/bin/env bash
set -euo pipefail

source "$PDE/scripts/utils.sh"

RIBYNS_PDE_LOG_INFO=true info "Installing webdev packages..."

sudo pacman -S --needed --noconfirm \
	nodejs \
	npm \
	nvm \
	docker \
	docker-compose \
	docker-buildx \
	postgresql \
	dotnet-runtime \
	dotnet-sdk \
	aspnet-runtime \
	aspnet-targeting-pack \
	jq

RIBYNS_PDE_LOG_INFO=true success "Webdev packages installed"
