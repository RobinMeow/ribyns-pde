#!/usr/bin/env bash


sudo pacman -S --needed --noconfirm rofi

mkdir -p "$HOME/.config/rofi"
cp -r "$PDE/.config/rofi/"* "$HOME/.config/rofi/"
