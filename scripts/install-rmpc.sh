#!/usr/bin/env bash

source "$PDE/scripts/utils.sh"
assert_pde_vars

source "$PDE/scripts/dispatch-distro.sh"

dispatch_arch sudo pacman -S --needed --noconfirm rmpc mpd
dispatch_fedora sudo dnf install -y rmpc mpd
