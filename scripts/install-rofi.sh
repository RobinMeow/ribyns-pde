#!/usr/bin/env bash
source "$PDE/scripts/utils.sh"
assert_pde_vars

case "$OSD_DISTRIBUTION" in
arch)
	sudo pacman -S --needed --noconfirm rofi
	;;
fedora)
	sudo dnf install -y rofi
	;;
*)
	warn "Distro '$OSD_DISTRIBUTION' not supported for installing rofi"
	;;
esac

mkdir -p "$HOME/.config/rofi"
cp -r "$PDE/.config/rofi/"* "$HOME/.config/rofi/"
