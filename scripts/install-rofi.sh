#!/usr/bin/env bash
source "$PDE/scripts/utils.sh"
assert_pde_vars

source "$PDE/scripts/dispatch-distro.sh"

dispatch_arch sudo pacman -S --needed --noconfirm rofi
dispatch_fedora sudo dnf install -y rofi

mkdir -p "$HOME/.config/rofi"
cp -r "$PDE/.config/rofi/"* "$HOME/.config/rofi/"
