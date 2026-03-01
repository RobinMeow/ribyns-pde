#!/usr/bin/env bash

PDE="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BACKUP="$HOME/dotfiles_backups/$(date +%Y%m%d%H%M%S)"

source "$PDE/scripts/utils.sh"
source "$PDE/scripts/detect_env.sh"
source "$PDE/scripts/detect_win_user.sh"

echo "Creating backup at $BACKUP"
mkdir -p "$BACKUP"

LOGFILE="$BACKUP/log.txt"
touch "$LOGFILE"
exec > >(tee -a "$LOGFILE") 2>&1

# Function to backup a file if it exists
backup_file() {
	local filepath="$1"
	local fname=""
	fname="$(basename "$filepath")"

	if [ -f "$filepath" ]; then
		mv "$filepath" "$BACKUP/$fname"
		echo "Moved $fname to backup $BACKUP/$fname"
	else
		echo "Skipped $fname (not found)"
	fi
}

# Backup + copy root dotfiles
# only updates partially
backup_file "$HOME/.wezterm_background.jpg"
backup_file "$HOME/.zshrc"
backup_file "$HOME/.dircolors"

echo "Installing dotfiles"

cp "$PDE/.zshrc" "$HOME/"
cp "$PDE/.dircolors" "$HOME/"
cp "$PDE/images/arch-gray-2880x1800.jpg" "$HOME/.wezterm_background.jpg"

echo "Installing .config directory"

./sync-nvim.sh

# Install WezTerm config (Linux or WSL)
# TODO: call sync-wezterm.sh (not yet existent)
cp_wezterm_config() {
	local dest=""

	detect_env
	if [[ "$OS_TYPE" == "wsl" ]]; then
		detect_win_user
		win_user=$WINDOWS_USER
		dest="/mnt/c/Users/$win_user/.wezterm.lua"
	else
		dest="$HOME/.wezterm.lua"
	fi

	if [ -f "$dest" ]; then
		echo "Replacing existing Windows WezTerm config at $dest"
		backup_file "$dest"
		cp "$PDE/.wezterm.lua" "$dest"
	else
		echo "No existing Windows WezTerm config found. Installing new one at $dest"
		mkdir -p "$(dirname "$dest")"
		cp "$PDE/.wezterm.lua" "$dest"
	fi
}

cp_wezterm_config

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

# Oh My Zsh

if [ ! -d "$HOME/.oh-my-zsh" ]; then
	echo "Oh My Zsh not found. Installing..."

	# Prevent auto-launching zsh after install
	RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

	echo "Oh My Zsh installed."
else
	echo "Skipped Oh My Zsh install (already installed)."
fi

# ZSH Plugins

# Default ZSH_CUSTOM if not set
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

mkdir -p "$ZSH_CUSTOM/plugins"

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

echo "Done. backup at $BACKUP"
