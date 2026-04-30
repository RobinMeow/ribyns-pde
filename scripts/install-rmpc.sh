#!/usr/bin/env bash

set -u
source "$RIBYNS_ENV/scripts/run_on_distro.sh"

run_on_arch sudo pacman -S --needed --noconfirm rmpc mpd extra/timidity++
run_on_fedora sudo dnf install -y rmpc mpd timidity++

mkdir -p "$HOME/.config/rmpc"
cp -r "$RIBYNS_ENV/.config/rmpc/"* "$HOME/.config/rmpc/"
