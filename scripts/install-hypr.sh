#!/usr/bin/env bash

set -u
source "$PDE/scripts/run_on_distro.sh"

run_on_arch sudo pacman -S --needed --noconfirm hyprland
run_on_fedora sudo dnf install -y hyprland

mkdir -p "$HOME/.config/hypr"
cp -r "$PDE/.config/hypr/"* "$HOME/.config/hypr/"
