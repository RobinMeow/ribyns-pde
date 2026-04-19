#!/usr/bin/env bash

PDE="${PDE:-$HOME/ribyns-pde}"

source "$PDE/scripts/clone_repo.sh"
dest="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
clone_repo "--depth=1" "https://github.com/romkatv/powerlevel10k.git" "$dest"

cp "$HOME/ribyns-pde/.p10k.zsh" "$HOME/.p10k.zsh"
