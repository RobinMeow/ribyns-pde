#!/usr/bin/env bash

mkdir -p "$HOME/.config/vale"
cp "$PDE/.config/vale/"* "$HOME/.config/vale/"
vale --config "$HOME/.config/vale/vale.ini" sync
