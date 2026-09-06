#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/run_on_distro.sh"
source "$RIBYN_ROOT/core/utils.sh"
info "installing thunderbird"

if on_arch; then
	sudo pacman -S --needed --noconfirm \
		thunderbird
elif on_fedora; then
	sudo dnf install --assumeyes \
		thunderbird
else
	error "distro not supported."
	exit 1
fi
