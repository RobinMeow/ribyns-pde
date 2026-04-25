#!/usr/bin/env bash

set -u
source "$PDE/scripts/run_on_distro.sh"

run_on_arch sudo pacman -S --needed --noconfirm bat
run_on_fedora sudo dnf install -y bat

mkdir -p "$HOME/.config/bat"
cp -r "$PDE/.config/bat/"* "$HOME/.config/bat/"
