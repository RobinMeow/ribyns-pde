#!/usr/bin/env bash
set -e


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
cp "$HOME/.p10k.zsh" "$PDE/.p10k.zsh"

if [[ "$OS_TYPE" == "wsl" ]]; then
	detect_win_user
	if [[ -z "$WINDOWS_USER" ]]; then
		error "Windows user not detected. Cannot copy .wezterm.lua"
		exit 1
	fi
	cp "/mnt/c/Users/$WINDOWS_USER/.wezterm.lua" "$PDE/.wezterm.lua"
else
	cp "$HOME/.wezterm.lua" "$PDE/.wezterm.lua"
fi

# Reset working directory (optional)
git -C "$PDE" diff
git -C "$PDE" checkout .

read -n 1 -rp "Run 'git clean -f'? [y/N]: " answer

# the preceding `read -n 1` command returns immediately after
# a single keypress without waiting for the user to hit Enter,
# the cursor stays on the same line as the prompt.
# The `echo` ensures that subsequent output from the script
# starts on a fresh line, keeping the terminal output clean.
echo

if [[ "$answer" =~ ^[Yy]$ ]]; then
	git -C "$PDE" clean -f
	success "\`git clean -f\` executed"
else
	info "skipped g\`git clean -f\`"
fi
