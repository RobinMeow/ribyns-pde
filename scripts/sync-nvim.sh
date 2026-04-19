#!/usr/bin/env bash

PDE="${PDE:-$HOME/ribyns-pde}"

# NOTE: i usually do this manually
# rm -rf "$HOME/.config/nvim/"

mkdir -p "$HOME/.config/nvim"
cp -r "$PDE/.config/nvim/"* "$HOME/.config/nvim/"
