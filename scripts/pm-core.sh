#!/usr/bin/env bash
set -euo pipefail

source "$PDE/scripts/utils.sh"
assert_pde_vars

RIBYNS_PDE_LOG_INFO=true info "Installing core packages..."

source "$PDE/scripts/run_on_distro.sh"

# gemini-cli is not available in the standard repo
if [[ -d "/home/linuxbrew/" ]]; then
	echo "skipping brew installed (already installed)"
else
	"$PDE/scripts/install-homebrew.sh"
	brew install gemini-cli
fi

run_on_arch <<'EOF'
	sudo pacman -S --needed --noconfirm \
		base-devel \
		gawk \
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
EOF
run_on_fedora <<'EOF'
	sudo dnf install -y \
		@development-tools \
		git \
		gawk \
		curl \
		zsh \
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

tldr --update

RIBYNS_PDE_LOG_INFO=true success "Core packages installed"
