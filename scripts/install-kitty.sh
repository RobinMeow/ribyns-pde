#!/usr/bin/env bash


sudo pacman -S --needed --noconfirm kitty

mkdir -p "$HOME/.config/kitty"
cp -r "$PDE/.config/kitty/"* "$HOME/.config/kitty/"
