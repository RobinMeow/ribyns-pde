#!/usr/bin/env bash
source "$PDE/scripts/utils.sh"
assert_pde_vars

source "$PDE/scripts/dispatch-distro.sh"

dispatch_arch sudo pacman -S --needed --noconfirm bat
dispatch_fedora sudo dnf install -y bat

mkdir -p "$HOME/.config/bat"
cp -r "$PDE/.config/bat/"* "$HOME/.config/bat/"
