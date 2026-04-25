#!/usr/bin/env bash

set -u
source "$PDE/scripts/run_on_distro.sh"

run_on_arch sudo pacman -S --needed --noconfirm rmpc mpd
run_on_fedora sudo dnf install -y rmpc mpd
