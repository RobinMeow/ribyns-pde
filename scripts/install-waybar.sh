#!/usr/bin/env bash


sudo pacman -S --needed --noconfirm waybar

mkdir -p "$HOME/.config/waybar"
cp -r "$PDE/.config/waybar/"* "$HOME/.config/waybar/"
