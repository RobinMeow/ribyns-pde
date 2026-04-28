#!/usr/bin/env bash

# NOTE: SUPER+Q to launch kitty
# hyprctl dispatch exit to forcefully close all apps and hypr

set -eu
source "$PDE/scripts/run_on_distro.sh"
source "$PDE/scripts/utils.sh.sh"

run_on_arch sudo pacman -S --needed --noconfirm hyprland hyprshutdown

run_on_fedora error "Hyprland on fedora is not set up" exit 1

-- NVIDIA

mkdir -p "$HOME/.config/hypr"
cp -r "$PDE/.config/hypr/"* "$HOME/.config/hypr/"
