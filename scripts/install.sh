#!/usr/bin/env bash

source "$PDE/scripts/utils.sh"

echo "Installing from source: $PDE"

info "Installing zsh"
"$PDE/scripts/install-zsh.sh"

info "Installing .gitconfig"
"$PDE/scripts/install-gitconfig.sh"

info "Installing bat"
"$PDE/scripts/install-bat.sh"

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

for arg in "$@"; do
	if [[ "$arg" == "--pm" ]]; then
		info "Installing core"
		"$PDE/scripts/pm-core.sh"
	elif [[ "$arg" == "--webdev" ]]; then
		info "Installing gadgets"
		"$PDE/scripts/pm-gadgets.sh"
	elif [[ "$arg" == "--gadgets" ]]; then
		info "Installing gadgets"
		"$PDE/scripts/pm-gadgets.sh"
	elif [[ "$arg" == "--kde" ]]; then
		info "Installing kde"
		"$PDE/scripts/install-kde.sh"
	elif [[ "$arg" == "--hypr" ]]; then
		info "Installing rofi"
		"$PDE/scripts/install-rofi.sh"

		info "Installing waybar"
		"$PDE/scripts/install-waybar.sh"

		info "Installing hypr"
		"$PDE/scripts/install-hypr.sh"
	fi
done

success "ribyns-pde installed"
