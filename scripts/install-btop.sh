#!/usr/bin/env bash

set -u
source "$PDE/scripts/run_on_distro.sh"

run_on_arch sudo pacman -S --needed --noconfirm btop
run_on_fedora sudo dnf install -y btop

mkdir -p "$HOME/.config/btop"
cp -r "$PDE/.config/btop/"* "$HOME/.config/btop/"
