#!/usr/bin/env bash

set -u
source "$PDE/scripts/run_on_distro.sh"

run_on_arch sudo pacman -S --needed --noconfirm rofi
run_on_fedora sudo dnf install -y rofi

mkdir -p "$HOME/.config/rofi"
cp -r "$PDE/.config/rofi/"* "$HOME/.config/rofi/"
