#!/usr/bin/env bash

PDE="${PDE:-$HOME/ribyns-pde}"

"$PDE/scripts/pacman-S.sh" waybar

mkdir -p "$HOME/.config/waybar"
cp -r "$PDE/.config/waybar/"* "$HOME/.config/waybar/"
