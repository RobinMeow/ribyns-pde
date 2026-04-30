#!/usr/bin/env bash

set -euo pipefail

source "$RIBYNS_ENV/scripts/utils.sh"

RIBYNS_ENV_LOG_INFO=true info "Installing core packages..."

source "$RIBYNS_ENV/scripts/run_on_distro.sh"

"$RIBYNS_ENV/scripts/ensure-homebrew-installed.sh"

run_on_arch <<'EOF'
	sudo pacman -S --needed --noconfirm \
		base-devel \
		gawk \
		git \
		curl \
		zsh \
		eza \
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
		ffmpeg \
		7zip \
		ripgrep \
		glow \
		mpv \
		chafa \
		fd \
		bluetui \
		zathura zathura-pdf-mupdf tesseract-data-eng
EOF

# TODO: bluetui requires build from source on fedora
run_on_fedora <<'EOF'
	sudo dnf install -y \
		@development-tools \
		git \
		gawk \
		curl \
		zsh \
		eza \
		vi \
		vim \
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
		lnav \
		tree \
		btop \
		translate-shell \
		tokei \
		flameshot \
		ffmpeg \
		7zip \
		ripgrep \
		glow \
		mpv \
		chafa \
		fd-find
EOF

# NOTE: gemini-cli is available in arch but might as well have things consistent
brew install gemini-cli

tldr --update

RIBYNS_ENV_LOG_INFO=true success "Core packages installed"
