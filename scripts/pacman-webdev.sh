#!/usr/bin/env bash
set -euo pipefail

source "$PDE/scripts/utils.sh"

source "$PDE/scripts/dispatch-distro.sh"

RIBYNS_PDE_LOG_INFO=true info "Installing webdev packages..."

dispatch_arch <<'EOF'
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
EOF

dispatch_fedora <<'EOF'
	sudo dnf install -y \
		nodejs \
		npm \
		docker \
		docker-compose \
		postgresql \
		jq
EOF

RIBYNS_PDE_LOG_INFO=true success "Webdev packages installed"
