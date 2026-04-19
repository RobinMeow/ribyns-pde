#!/usr/bin/env bash

set -euo pipefail

PDE="${PDE:-$HOME/ribyns-pde}"
source "$PDE/scripts/utils.sh"

if [[ "${RIBYNS_PDE_INSTALL_PACMAN:-}" != "true" ]]; then
	info "Skipping pacman install for: $*"
	exit 0
fi

if [[ "${RIBYNS_PDE_PACMAN_UPDATE:-0}" == "1" ]]; then
	sudo pacman -S "$@" --noconfirm
else
	sudo pacman -S --needed "$@" --noconfirm
fi
