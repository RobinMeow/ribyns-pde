#!/usr/bin/env bash
set -e

PDE="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

source "$PDE/scripts/utils.sh"
source "$PDE/scripts/detect_env.sh"
detect_env

# Check for clean git state and no added untracked files
if ! git -C "$PDE" diff-index --quiet HEAD -- || [[ -n "$(git -C "$PDE" ls-files --others --exclude-standard)" ]]; then
	error "Git repository has uncommitted changes. Please commit or stash them first"
	exit 1
fi

cp -r "$HOME/.config/nvim" "$PDE/.config/"
cp "$HOME/.zshrc" "$PDE/.zshrc"
case "$OS_TYPE" in
wsl)
	# TODO: (for another day, ignore) automatic windows user detection with fallback for prompt on multiple users with 1, 2, 3 selection
	cp "/mnt/c/Users/Ribyn/.wezterm.lua" "$PDE/.wezterm.lua"
	;;
*)
	cp "$HOME/.wezterm.lua" "$PDE/.wezterm_native.lua"
	;;
esac

# Reset working directory (optional)
git -C "$PDE" diff
git -C "$PDE" checkout .

# same as [[ "$1" == "--clean" || "$1" == "-c" || "$1" == "clean" ]]
if [[ "$1" =~ (--clean|-c|clean) ]]; then
	git -C "$PDE" clean -f
	success "Git clean executed"
else
	info "Skipped git clean"
fi
