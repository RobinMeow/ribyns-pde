#!/usr/bin/env bash
source "$PDE/scripts/utils.sh"
assert_pde_vars

case "$OSD_DISTRIBUTION" in
arch)
	sudo pacman -S --needed --noconfirm bat
	;;
fedora)
	sudo dnf install -y bat
	;;
*)
	warn "Distro '$OSD_DISTRIBUTION' not supported for installing bat"
	;;
esac

mkdir -p "$HOME/.config/bat"
cp -r "$PDE/.config/bat/"* "$HOME/.config/bat/"
