#!/usr/bin/env bash
source "$PDE/scripts/utils.sh"
assert_pde_vars

case "$OSD_DISTRIBUTION" in
arch)
	sudo pacman -S --needed --noconfirm waybar
	;;
fedora)
	sudo dnf install -y waybar
	;;
*)
	warn "Distro '$OSD_DISTRIBUTION' not supported for installing waybar"
	;;
esac

mkdir -p "$HOME/.config/waybar"
cp -r "$PDE/.config/waybar/"* "$HOME/.config/waybar/"
