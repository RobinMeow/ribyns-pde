#!/usr/bin/env bash

PDE="${PDE:-$HOME/ribyns-pde}"

mkdir -p "$HOME/.config/hypr"
cp -r "$PDE/.config/hypr/"* "$HOME/.config/hypr/"
