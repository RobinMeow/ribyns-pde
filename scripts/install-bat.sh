#!/usr/bin/env bash

set -u
source "$RIBYNS_ENV/scripts/run_on_distro.sh"

run_on_arch sudo pacman -S --needed --noconfirm bat
run_on_fedora sudo dnf install -y bat

mkdir -p "$HOME/.config/bat"
cp -r "$RIBYNS_ENV/.config/bat/"* "$HOME/.config/bat/"
