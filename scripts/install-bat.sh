#!/usr/bin/env bash

PDE="${PDE:-$HOME/ribyns-pde}"

"$PDE/scripts/pacman-S.sh" bat

mkdir -p "$HOME/.config/bat"
cp -r "$PDE/.config/bat/"* "$HOME/.config/bat/"
