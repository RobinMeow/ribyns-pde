#!/usr/bin/env bash

PDE="${PDE:-$HOME/ribyns-pde}"

"$PDE/scripts/pacman-S.sh" hyprland

mkdir -p "$HOME/.config/hypr"
cp -r "$PDE/.config/hypr/"* "$HOME/.config/hypr/"
