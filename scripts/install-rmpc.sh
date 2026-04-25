#!/usr/bin/env bash

source "$PDE/scripts/utils.sh"
assert_pde_vars

# https://rmpc.mierak.dev/installation/
# https://mpd.readthedocs.io/en/stable/user.html

sudo pacman -S --needed --noconfirm rmpc mpd
