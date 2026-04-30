#!/usr/bin/env bash

set -u
source "$RIBYNS_ENV/scripts/run_on_distro.sh"

run_on_arch sudo pacman -S --needed --noconfirm btop
run_on_fedora sudo dnf install -y btop

mkdir -p "$HOME/.config/btop"
cp -r "$RIBYNS_ENV/.config/btop/"* "$HOME/.config/btop/"
