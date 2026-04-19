#!/usr/bin/env bash

PDE="${PDE:-$HOME/ribyns-pde}"

mkdir -p "$HOME/.config/kitty"
cp -r "$PDE/.config/kitty/"* "$HOME/.config/kitty/"
