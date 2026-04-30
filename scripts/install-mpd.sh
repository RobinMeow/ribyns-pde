#!/usr/bin/env bash

set -u
source "$RIBYNS_ENV/scripts/run_on_distro.sh"

run_on_arch sudo pacman -S --needed --noconfirm mpd rmpc
run_on_fedora sudo dnf install -y mpd rmpc

mkdir -p "$HOME/.config/mpd/playlists"
cp -r "$RIBYNS_ENV/.config/mpd/"* "$HOME/.config/mpd/"
mkdir -p "$HOME/.local/state/mpd"

mkdir -p "$HOME/.config/rmpc"
cp -r "$RIBYNS_ENV/.config/rmpc/"* "$HOME/.config/rmpc/"
