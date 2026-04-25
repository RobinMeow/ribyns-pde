#!/usr/bin/env bash

set -u
source "$PDE/scripts/run_on_distro.sh"

run_on_arch sudo pacman -S --needed --noconfirm kitty
run_on_fedora sudo dnf install -y kitty

mkdir -p "$HOME/.config/kitty"
cp -r "$PDE/.config/kitty/"* "$HOME/.config/kitty/"
