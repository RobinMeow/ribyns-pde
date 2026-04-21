#!/usr/bin/env bash

sudo pacman -S --needed --noconfirm nvim tree-sitter-cli lazygit

# NOTE: i usually do this manually
# rm -rf "$HOME/.config/nvim/"

mkdir -p "$HOME/.config/nvim"
cp -r "$PDE/.config/nvim/"* "$HOME/.config/nvim/"
