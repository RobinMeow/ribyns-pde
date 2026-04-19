#!/usr/bin/env bash

PDE="${PDE:-$HOME/ribyns-pde}"

source "$PDE/scripts/utils.sh"
source "$PDE/scripts/stopwatch.sh"
temp=RIBYNS_STOPWATCH_ENABLED
RIBYNS_STOPWATCH_ENABLED=true
sw="installed in"
start "$sw"

echo "Installing from source: $PDE"

# TODO: modularize this by invoking a script for each domain
info "Installing .config"
cp -r "$PDE/.config" "$HOME/"

# NOTE: .config sync already includes it
# info "Installing .config/nvim"
# "$PDE/scripts/install-nvim.sh"

info "Installing Wezterm"
"$PDE/scripts/install-wezterm.sh"

info "Installing .gitconfig"
"$PDE/scripts/install-gitconfig.sh"

info "Installing zsh"
"$PDE/scripts/install-zsh.sh"

info "Installing powerlevel10k"
"$PDE/scripts/p10k.sh"

stop "$sw"
success "ribyns-pde installed"
RIBYNS_STOPWATCH_ENABLED=$temp
