#!/usr/bin/env bash

PDE="${PDE:-$HOME/ribyns-pde}"

mkdir -p "$HOME/.config/rofi"
cp -r "$PDE/.config/rofi/"* "$HOME/.config/rofi/"
