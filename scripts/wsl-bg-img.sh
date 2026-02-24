#!/bin/bash

# usage: bash wsl-bg-img.sh <windows username>
# example c/Users/firstname.lastname
# bash wsl-bg-img.sh firstname.lastname

cp "$HOME/ribyns-pde/images/arch-gray-2880x1800.jpg" "/mnt/c/Users/$1/.wezterm_background.jpg"

