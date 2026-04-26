#!/usr/bin/env bash

source "$PDE/scripts/utils.sh"

echo "Installing from source: $PDE"

info "Installing zsh"
"$PDE/scripts/install-zsh.sh"

info "Installing CommitMono"
"$PDE/scripts/install-commit-mono.sh"

info "Installing .gitconfig"
"$PDE/scripts/install-gitconfig.sh"

info "Installing bat"
"$PDE/scripts/install-bat.sh"

info "Installing btop"
"$PDE/scripts/install-btop.sh"

info "Installing kitty"
"$PDE/scripts/install-kitty.sh"

info "Installing wezterm"
"$PDE/scripts/install-wezterm.sh"

info "Installing nvim"
"$PDE/scripts/install-nvim.sh"

info "Installing tmux"
"$PDE/scripts/install-tmux.sh"

info "Installing yazi"
"$PDE/scripts/install-yazi.sh"

full_install=false
for arg in "$@"; do
	if [[ "$arg" == "--full-install" ]]; then
		full_install=true
	fi
done

for arg in "$@"; do
	if [[ "$arg" == "--pm" || $full_install ]]; then
		info "Installing core"
		"$PDE/scripts/pm-core.sh"
	fi
	if [[ "$arg" == "--webdev" || $full_install ]]; then
		info "Installing gadgets"
		"$PDE/scripts/pm-gadgets.sh"
	fi
	if [[ "$arg" == "--gadgets" || $full_install ]]; then
		info "Installing gadgets"
		"$PDE/scripts/pm-gadgets.sh"
	fi
	if [[ "$arg" == "--kde" || $full_install ]]; then
		info "Installing kde"
		"$PDE/scripts/install-kde.sh"
	fi
	if [[ "$arg" == "--hypr" || $full_install ]]; then
		info "Installing rofi"
		"$PDE/scripts/install-rofi.sh"

		info "Installing waybar"
		"$PDE/scripts/install-waybar.sh"

		info "Installing hypr"
		"$PDE/scripts/install-hypr.sh"
	fi
done

success "ribyns-pde installed"
