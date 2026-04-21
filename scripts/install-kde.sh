#!/usr/bin/env bash


# kde config files are usually directly in .config
mkdir -p "$HOME/.config"
cp "$PDE/.config/kwalletrc" "$HOME/.config/kwalletrc"
