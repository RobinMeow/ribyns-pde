#!/usr/bin/env bash
source "$PDE/scripts/utils.sh"
assert_pde_vars

case "$OSD_DISTRIBUTION" in
arch)
	sudo pacman -S --needed --noconfirm mpd rmpc
	;;
fedora)
	sudo dnf install -y mpd rmpc
	;;
*)
	warn "Distro '$OSD_DISTRIBUTION' not supported for installing mpd"
	;;
esac

mkdir -p "$HOME/.config/mpd/playlists"
cp -r "$PDE/.config/mpd/"* "$HOME/.config/mpd/"
mkdir -p "$HOME/.local/state/mpd"

mkdir -p "$HOME/.config/rmpc"
cp -r "$PDE/.config/rmpc/"* "$HOME/.config/rmpc/"
