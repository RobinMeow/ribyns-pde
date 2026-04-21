#!/usr/bin/env bash


sudo pacman -S --needed --noconfirm hyprland

mkdir -p "$HOME/.config/hypr"
cp -r "$PDE/.config/hypr/"* "$HOME/.config/hypr/"
