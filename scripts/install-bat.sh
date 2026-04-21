#!/usr/bin/env bash


sudo pacman -S --needed --noconfirm bat

mkdir -p "$HOME/.config/bat"
cp -r "$PDE/.config/bat/"* "$HOME/.config/bat/"
