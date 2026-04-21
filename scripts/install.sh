#!/usr/bin/env bash

source "$PDE/scripts/utils.sh"

echo "Installing from source: $PDE"

info "Installing zsh"
"$PDE/scripts/install-zsh.sh"

info "Installing .gitconfig"
"$PDE/scripts/install-gitconfig.sh"

info "Installing powerlevel10k"
"$PDE/scripts/install-p10k.sh"

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
	if [[ "$arg" == "--pacman" ]]; then
		info "Installing pacman packages"
		"$PDE/scripts/pacman-core.sh"
		"$PDE/scripts/pacman-webdev.sh"
	fi
done

for arg in "$@"; do
	# NOTE: disabled since I currently dont need them synced anywhere
	if [[ "$arg" == "--desktop" ]]; then
		info "Installing rofi"
		"$PDE/scripts/install-rofi.sh"

		info "Installing waybar"
		"$PDE/scripts/install-waybar.sh"

		# INFO: i can split up hypr and kde in future
		info "Installing hypr"
		"$PDE/scripts/install-hypr.sh"

		info "Installing kde"
		"$PDE/scripts/install-kde.sh"
	fi
done

success "ribyns-pde installed"
