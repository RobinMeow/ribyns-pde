#!/usr/bin/env bash
source "$PDE/scripts/utils.sh"
assert_pde_vars

source "$PDE/scripts/dispatch-distro.sh"

dispatch_arch sudo pacman -S --needed --noconfirm kitty
dispatch_fedora sudo dnf install -y kitty

mkdir -p "$HOME/.config/kitty"
cp -r "$PDE/.config/kitty/"* "$HOME/.config/kitty/"
