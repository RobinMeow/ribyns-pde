#!/usr/bin/env bash

PDE="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SCRIPT_DIR="$PDE/scripts"

source "$PDE/scripts/utils.sh"
source "$PDE/scripts/detect_env.sh"
source "$PDE/scripts/detect_win_user.sh"

info "Installing dircolors"
cp "$PDE/.dircolors" "$HOME/" # TODO: i should check if i actually still need this

info "Installing NeoVim"
"$SCRIPT_DIR/sync-nvim.sh"

info "Installing WezTerm"
"$SCRIPT_DIR/sync-wezterm.sh"

info "Installing zsh and oh-my-zsh"
cp "$PDE/.zshrc" "$HOME/"
if [ ! -d "$HOME/.oh-my-zsh" ]; then
	echo "Installing Oh My Zsh..."
	# Prevent auto-launching zsh after install
	RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	echo "Oh My Zsh installed"
else
	echo "Skipped Oh My Zsh install (already installed)"
fi

# Default ZSH_CUSTOM if not set
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
mkdir -p "$ZSH_CUSTOM/plugins"

clone_repo() {
	local url="$1"
	local target="$2"

	if [ ! -d "$target" ]; then
		git clone "$url" "$target"
		echo "Cloned $url"
	else
		echo "Skipped clone (already exists): $target"
	fi
}
clone_repo https://github.com/jeffreytse/zsh-vi-mode "$ZSH_CUSTOM/plugins/zsh-vi-mode"
clone_repo https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
clone_repo https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
clone_repo https://github.com/zsh-users/zsh-completions.git "$ZSH_CUSTOM/plugins/zsh-completions"

# TMUX Plugins
# (KEPT for if i want tmux back. e.g. when i use some ssh stuff which is not as good supported by wezterm)
#
# TMUX_PLUGIN_DIR="$HOME/.config/tmux/plugins"
# mkdir -p "$TMUX_PLUGIN_DIR"
#
# clone_repo https://github.com/catppuccin/tmux "$TMUX_PLUGIN_DIR/catppuccin"
# clone_repo https://github.com/tmux-plugins/tmux-cpu "$TMUX_PLUGIN_DIR/tmux-cpu"
# clone_repo https://github.com/tmux-plugins/tmux-battery "$TMUX_PLUGIN_DIR/tmux-battery"
# clone_repo https://github.com/tmux-plugins/tmux-yank "$TMUX_PLUGIN_DIR/tmux-yank"

success "ribyns-pde installed"
