#!/usr/bin/env bash

PDE="${PDE:-$HOME/ribyns-pde}"

source "$PDE/scripts/utils.sh"

# TODO: modularize this by invoking a script for each domain
info "Syncing .config"
cp -r "$PDE/.config" "$HOME/"

info "Syncing Wezterm"
"$PDE/scripts/sync-wezterm.sh"

info "Syncing .gitconfig"
"$PDE/scripts/sync-gitconfig.sh"

info "Syncing zsh"
"$PDE/scripts/sync-zsh.sh"

info "Syncing powerlevel10k"
"$PDE/scripts/p10k.sh"

success "ribyns-pde synced"
