#!/usr/bin/env bash
source "$PDE/scripts/utils.sh"
assert_pde_vars

source "$PDE/scripts/dispatch-distro.sh"

dispatch_arch sudo pacman -S --needed --noconfirm waybar
dispatch_fedora sudo dnf install -y waybar

mkdir -p "$HOME/.config/waybar"
cp -r "$PDE/.config/waybar/"* "$HOME/.config/waybar/"
