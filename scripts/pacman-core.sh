#!/usr/bin/env bash
set -euo pipefail

PDE="${PDE:-$HOME/ribyns-pde}"
source "$PDE/scripts/utils.sh"

RIBYNS_PDE_LOG_INFO=true info "Installing core packages..."

"$PDE/scripts/pacman-S.sh" \
	base-devel \
	git \
	curl \
	zsh \
	vi \
	vim \
	nvim \
	tree-sitter-cli \
	unzip \
	xclip \
	wl-clipboard \
	openssh \
	navi \
	fastfetch \
	bc \
	ncdu \
	cargo \
	man-db \
	man-pages \
	tealdeer

# Update tealdeer cache if it was just installed
if command -v tldr >/dev/null 2>&1; then
	tldr --update
fi

RIBYNS_PDE_LOG_INFO=true success "Core packages installed"
