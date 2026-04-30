#!/usr/bin/env bash

set -u
source "$RIBYNS_ENV/scripts/run_on_distro.sh"

run_on_arch sudo pacman -S --needed --noconfirm tmux
run_on_fedora sudo dnf install -y tmux

# TMUX Plugins
TMUX_PLUGIN_DIR="$HOME/.config/tmux/plugins"
mkdir -p "$TMUX_PLUGIN_DIR"

cp "$RIBYNS_ENV/.tmux.conf" "$HOME/.tmux.conf"

source "$RIBYNS_ENV/scripts/clone_repo.sh"
clone_repo https://github.com/catppuccin/tmux "$TMUX_PLUGIN_DIR/catppuccin"
clone_repo https://github.com/tmux-plugins/tmux-cpu "$TMUX_PLUGIN_DIR/tmux-cpu"
clone_repo https://github.com/tmux-plugins/tmux-battery "$TMUX_PLUGIN_DIR/tmux-battery"
clone_repo https://github.com/tmux-plugins/tmux-yank "$TMUX_PLUGIN_DIR/tmux-yank"
