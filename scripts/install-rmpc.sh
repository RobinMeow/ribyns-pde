#!/usr/bin/env bash

# https://rmpc.mierak.dev/installation/
# https://mpd.readthedocs.io/en/stable/user.html

PDE="${PDE:-$HOME/ribyns-pde}"
"$PDE/scripts/pacman-S.sh" rmpc mpd
