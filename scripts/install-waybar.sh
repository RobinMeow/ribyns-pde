#!/usr/bin/env bash

PDE="${PDE:-$HOME/ribyns-pde}"

mkdir -p "$HOME/.config/waybar"
cp -r "$PDE/.config/waybar/"* "$HOME/.config/waybar/"
