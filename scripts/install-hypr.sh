#!/usr/bin/env bash

# NOTE: SUPER+Q to launch kitty
# hyprctl dispatch exit to forcefully close all apps and hypr

set -eu
source "$RIBYNS_ENV/scripts/run_on_distro.sh"
source "$RIBYNS_ENV/scripts/utils.sh"

run_on_arch sudo pacman -S --needed --noconfirm hyprland hyprshutdown

run_on_fedora error "Hyprland on fedora is not set up" exit 1

-- NVIDIA

mkdir -p "$HOME/.config/hypr"
cp -r "$RIBYNS_ENV/.config/hypr/"* "$HOME/.config/hypr/"
