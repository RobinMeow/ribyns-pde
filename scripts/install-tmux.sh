#!/usr/bin/env bash
source "$PDE/scripts/utils.sh"
assert_pde_vars

case "$OSD_DISTRIBUTION" in
arch)
	sudo pacman -S --needed --noconfirm tmux
	;;
fedora)
	sudo dnf install -y tmux
	;;
*)
	warn "Distro '$OSD_DISTRIBUTION' not supported for installing tmux"
	;;
esac

# TMUX Plugins
TMUX_PLUGIN_DIR="$HOME/.config/tmux/plugins"
mkdir -p "$TMUX_PLUGIN_DIR"

cp "$PDE/.tmux.conf" "$HOME/.tmux.conf"

source "$PDE/scripts/clone_repo.sh"
clone_repo https://github.com/catppuccin/tmux "$TMUX_PLUGIN_DIR/catppuccin"
clone_repo https://github.com/tmux-plugins/tmux-cpu "$TMUX_PLUGIN_DIR/tmux-cpu"
clone_repo https://github.com/tmux-plugins/tmux-battery "$TMUX_PLUGIN_DIR/tmux-battery"
clone_repo https://github.com/tmux-plugins/tmux-yank "$TMUX_PLUGIN_DIR/tmux-yank"
