#!/usr/bin/env bash

source "$RIBYNS_ENV/scripts/utils.sh"

echo "Installing from source: $RIBYNS_ENV"

info "Installing zsh"
"$RIBYNS_ENV/scripts/install-zsh.sh"

info "Installing CommitMono"
"$RIBYNS_ENV/scripts/install-commit-mono.sh"

info "Installing .gitconfig"
"$RIBYNS_ENV/scripts/install-gitconfig.sh"

info "Installing bat"
"$RIBYNS_ENV/scripts/install-bat.sh"

info "Installing btop"
"$RIBYNS_ENV/scripts/install-btop.sh"

info "Installing kitty"
"$RIBYNS_ENV/scripts/install-kitty.sh"

info "Installing wezterm"
"$RIBYNS_ENV/scripts/install-wezterm.sh"

info "Installing nvim"
"$RIBYNS_ENV/scripts/install-nvim.sh"

info "Installing tmux"
"$RIBYNS_ENV/scripts/install-tmux.sh"

info "Installing yazi"
"$RIBYNS_ENV/scripts/install-yazi.sh"

full_install=false
for arg in "$@"; do
	if [[ "$arg" == "--full-install" ]]; then
		full_install=true
	fi
done

for arg in "$@"; do
	if [[ "$arg" == "--pm" || $full_install ]]; then
		info "Installing core"
		"$RIBYNS_ENV/scripts/pm-core.sh"
	fi

	if [[ "$arg" == "--webdev" || $full_install ]]; then
		info "Installing gadgets"
		"$RIBYNS_ENV/scripts/pm-gadgets.sh"
	fi

	if [[ "$arg" == "--gadgets" ]]; then
		info "Installing gadgets"
		"$RIBYNS_ENV/scripts/pm-gadgets.sh"
	fi

	if [[ "$arg" == "--kde" ]]; then
		info "Installing kde"
		"$RIBYNS_ENV/scripts/install-kde.sh"
	fi

	if [[ "$arg" == "--hypr" ]]; then
		info "Installing rofi"
		"$RIBYNS_ENV/scripts/install-rofi.sh"

		info "Installing waybar"
		"$RIBYNS_ENV/scripts/install-waybar.sh"

		info "Installing hypr"
		"$RIBYNS_ENV/scripts/install-hypr.sh"
	fi
done

success "ribyns-env installed"
