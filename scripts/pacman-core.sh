#!/usr/bin/env bash
set -euo pipefail

source "$PDE/scripts/utils.sh"

RIBYNS_PDE_LOG_INFO=true info "Installing core packages..."

sudo pacman -S --needed --noconfirm \
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
	tealdeer \
	vlc \
	vlc-plugins-all \
	lnav \
	tree \
	btop \
	translate-shell \
	tokei \
	flameshot \
	gemini-cli \
	ffmpeg \
	7zip \
	ripgrep \
	glow \
	mpv \
	chafa \
	fd

tldr --update

RIBYNS_PDE_LOG_INFO=true success "Core packages installed"
