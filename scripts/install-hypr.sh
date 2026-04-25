#!/usr/bin/env bash

source "$PDE/scripts/utils.sh"
assert_pde_vars

source "$PDE/scripts/dispatch-distro.sh"

dispatch_arch sudo pacman -S --needed --noconfirm hyprland
dispatch_fedora sudo dnf install -y hyprland

mkdir -p "$HOME/.config/hypr"
cp -r "$PDE/.config/hypr/"* "$HOME/.config/hypr/"
