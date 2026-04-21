#!/usr/bin/env bash

PDE="${PDE:-$HOME/ribyns-pde}"

"$PDE/scripts/pacman-S.sh" rofi

mkdir -p "$HOME/.config/rofi"
cp -r "$PDE/.config/rofi/"* "$HOME/.config/rofi/"
