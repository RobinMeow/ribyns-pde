#!/usr/bin/env bash

set -u
source "$RIBYNS_ENV/scripts/run_on_distro.sh"

run_on_arch sudo pacman -S --needed --noconfirm rofi
run_on_fedora sudo dnf install -y rofi

mkdir -p "$HOME/.config/rofi"
cp -r "$RIBYNS_ENV/.config/rofi/"* "$HOME/.config/rofi/"
