#!/usr/bin/env bash

sudo pacman -S --needed --noconfirm zsh curl git

source "$PDE/scripts/utils.sh"

if [ ! -d "$HOME/.oh-my-zsh" ]; then
	info "Installing Oh My Zsh"
	# Prevent auto-launching zsh after install
	RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	success "Oh My Zsh installed"
else
	verbose "skipped Oh My Zsh install (already installed)"
fi
cp "$PDE/.zshrc" "$HOME/.zshrc"

# Default ZSH_CUSTOM if not set
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
mkdir -p "$ZSH_CUSTOM/plugins"

source "$PDE/scripts/clone_repo.sh"
clone_repo --depth 1 https://github.com/jeffreytse/zsh-vi-mode "$ZSH_CUSTOM/plugins/zsh-vi-mode"
clone_repo --depth 1 https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
clone_repo --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
clone_repo --depth 1 https://github.com/zsh-users/zsh-completions.git "$ZSH_CUSTOM/plugins/zsh-completions"
