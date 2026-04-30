#!/usr/bin/env bash
set -e


source "$RIBYNS_ENV/scripts/utils.sh"
source "$RIBYNS_ENV/scripts/detect_env.sh"
source "$RIBYNS_ENV/scripts/detect_win_user.sh"
detect_env

# Check for clean git state and no added untracked files
if ! git -C "$RIBYNS_ENV" diff-index --quiet HEAD -- || [[ -n "$(git -C "$RIBYNS_ENV" ls-files --others --exclude-standard)" ]]; then
	error "Git repository has uncommitted changes. Please commit or stash them first"
	exit 1
fi

cp -r "$HOME/.config/nvim" "$RIBYNS_ENV/.config/"
cp "$HOME/.zshrc" "$RIBYNS_ENV/.zshrc"
cp "$HOME/.p10k.zsh" "$RIBYNS_ENV/.p10k.zsh"

if [[ "$OS_TYPE" == "wsl" ]]; then
	detect_win_user
	if [[ -z "$WINDOWS_USER" ]]; then
		error "Windows user not detected. Cannot copy .wezterm.lua"
		exit 1
	fi
	cp "/mnt/c/Users/$WINDOWS_USER/.wezterm.lua" "$RIBYNS_ENV/.wezterm.lua"
else
	cp "$HOME/.wezterm.lua" "$RIBYNS_ENV/.wezterm.lua"
fi

# Reset working directory (optional)
git -C "$RIBYNS_ENV" diff
git -C "$RIBYNS_ENV" checkout .

read -n 1 -rp "Run 'git clean -f'? [y/N]: " answer

# the preceding `read -n 1` command returns immediately after
# a single keypress without waiting for the user to hit Enter,
# the cursor stays on the same line as the prompt.
# The `echo` ensures that subsequent output from the script
# starts on a fresh line, keeping the terminal output clean.
echo

if [[ "$answer" =~ ^[Yy]$ ]]; then
	git -C "$RIBYNS_ENV" clean -f
	success "\`git clean -f\` executed"
else
	info "skipped g\`git clean -f\`"
fi
