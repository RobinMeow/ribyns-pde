#!/usr/bin/env bash

source "$PDE/scripts/utils.sh"
assert_pde_vars


sudo pacman -S --needed --noconfirm hyprland

mkdir -p "$HOME/.config/hypr"
cp -r "$PDE/.config/hypr/"* "$HOME/.config/hypr/"
