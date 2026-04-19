#!/usr/bin/env bash

PDE="${PDE:-$HOME/ribyns-pde}"

source "$PDE/scripts/utils.sh"
source "$PDE/scripts/stopwatch.sh"
temp=RIBYNS_STOPWATCH_ENABLED
RIBYNS_STOPWATCH_ENABLED=true
sw="installed in"
start "$sw"

echo "Syncing from source: $PDE"

# TODO: modularize this by invoking a script for each domain
info "Syncing .config"
cp -r "$PDE/.config" "$HOME/"

# NOTE: .config sync already includes it
# info "Syncing .config/nvim"
# "$PDE/scripts/sync-nvim.sh"

info "Syncing Wezterm"
"$PDE/scripts/sync-wezterm.sh"

info "Syncing .gitconfig"
"$PDE/scripts/sync-gitconfig.sh"

info "Syncing zsh"
"$PDE/scripts/sync-zsh.sh"

info "Syncing powerlevel10k"
"$PDE/scripts/p10k.sh"

stop "$sw"
success "ribyns-pde synced"
RIBYNS_STOPWATCH_ENABLED=$temp
