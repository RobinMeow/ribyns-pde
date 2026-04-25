#!/usr/bin/env bash

set -u
source "$PDE/scripts/run_on_distro.sh"

run_on_arch sudo pacman -S --needed --noconfirm waybar
run_on_fedora sudo dnf install -y waybar

mkdir -p "$HOME/.config/waybar"
cp -r "$PDE/.config/waybar/"* "$HOME/.config/waybar/"
