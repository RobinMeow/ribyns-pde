#!/usr/bin/env bash

PDE="${PDE:-$HOME/ribyns-pde}"

mkdir -p "$HOME/.config/yazi"
cp -r "$PDE/.config/yazi/"* "$HOME/.config/yazi/"
