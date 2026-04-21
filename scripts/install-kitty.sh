#!/usr/bin/env bash

PDE="${PDE:-$HOME/ribyns-pde}"

"$PDE/scripts/pacman-S.sh" kitty

mkdir -p "$HOME/.config/kitty"
cp -r "$PDE/.config/kitty/"* "$HOME/.config/kitty/"
