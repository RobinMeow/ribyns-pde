#!/usr/bin/env bash


source "$PDE/scripts/utils.sh"
source "$PDE/scripts/stopwatch.sh"

# Argument parsing
RUN_PACMAN=false
for arg in "$@"; do
	if [[ "$arg" == "--pacman" ]]; then
		export RIBYNS_PDE_INSTALL_PACMAN=true
		RUN_PACMAN=true
	fi
done

temp=RIBYNS_STOPWATCH_ENABLED
RIBYNS_STOPWATCH_ENABLED=true
sw="installed in"
start "$sw"

echo "Installing from source: $PDE"

info "Installing zsh"
"$PDE/scripts/install-zsh.sh"

info "Installing .gitconfig"
"$PDE/scripts/install-gitconfig.sh"

info "Installing powerlevel10k"
"$PDE/scripts/install-p10k.sh"

info "Installing bat"
"$PDE/scripts/install-bat.sh"

info "Installing hypr"
"$PDE/scripts/install-hypr.sh"

info "Installing kitty"
"$PDE/scripts/install-kitty.sh"

info "Installing nvim"
"$PDE/scripts/install-nvim.sh"

info "Installing rofi"
"$PDE/scripts/install-rofi.sh"

info "Installing waybar"
"$PDE/scripts/install-waybar.sh"

info "Installing wezterm"
"$PDE/scripts/install-wezterm.sh"

info "Installing tmux"
"$PDE/scripts/install-tmux.sh"

info "Installing yazi"
"$PDE/scripts/install-yazi.sh"

info "Installing kde"
"$PDE/scripts/install-kde.sh"

if [[ "$RUN_PACMAN" == true ]]; then
	info "Installing core pacman packages"
	"$PDE/scripts/pacman-core.sh"
fi

stop "$sw"
success "ribyns-pde installed"
RIBYNS_STOPWATCH_ENABLED=$temp
unset RIBYNS_PDE_INSTALL_PACMAN
