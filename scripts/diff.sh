#!/usr/bin/env bash
set -e

PDE="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

source "$PDE/scripts/utils.sh"
source "$PDE/scripts/detect_env.sh"
source "$PDE/scripts/detect_win_user.sh"
detect_env

# Check for clean git state and no added untracked files
if ! git -C "$PDE" diff-index --quiet HEAD -- || [[ -n "$(git -C "$PDE" ls-files --others --exclude-standard)" ]]; then
	error "Git repository has uncommitted changes. Please commit or stash them first"
	exit 1
fi

cp -r "$HOME/.config/nvim" "$PDE/.config/"
cp "$HOME/.zshrc" "$PDE/.zshrc"

if [[ "$OS_TYPE" == "wsl" ]]; then
	detect_win_user
	if [[ -z "$WINDOWS_USER" ]]; then
		error "Windows user not detected. Cannot copy .wezterm.lua"
		exit 1
	fi
	cp "/mnt/c/Users/$WINDOWS_USER/.wezterm.lua" "$PDE/.wezterm.lua"
else
	cp "$HOME/.wezterm.lua" "$PDE/.wezterm_native.lua"
fi

# Reset working directory (optional)
git -C "$PDE" diff
git -C "$PDE" checkout .

if [[ "$1" == "--no-clean" ]]; then
	info "Skipped git clean"
else
	git -C "$PDE" clean -f
	success "Git clean executed"
fi
