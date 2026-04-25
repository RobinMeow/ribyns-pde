#!/usr/bin/env bash
source "$PDE/scripts/utils.sh"
assert_pde_vars

case "$OSD_DISTRIBUTION" in
arch)
	sudo pacman -S --needed --noconfirm kitty
	;;
fedora)
	sudo dnf install -y kitty
	;;
*)
	warn "Distro '$OSD_DISTRIBUTION' not supported for installing kitty"
	;;
esac

mkdir -p "$HOME/.config/kitty"
cp -r "$PDE/.config/kitty/"* "$HOME/.config/kitty/"
