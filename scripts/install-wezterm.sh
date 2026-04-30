#!/usr/bin/env bash

set -u
source "$RIBYNS_ENV/scripts/utils.sh"
source "$RIBYNS_ENV/scripts/run_on_distro.sh"

run_on_arch sudo pacman -S --needed --noconfirm wezterm
run_on_fedora <<'EOF'
sudo dnf copr enable -y wezfurlong/wezterm-nightly
sudo dnf install -y wezterm
EOF

WEZTERM_CONFIG_DIR="$HOME/.config/wezterm"
WEZTERM_LUA_DIR="$HOME"
source "$RIBYNS_ENV/scripts/detect_env.sh"
detect_env

if [[ "$OS_TYPE" == "wsl" ]]; then
	source "$RIBYNS_ENV/scripts/detect_win_user.sh"
	detect_win_user

	WEZTERM_CONFIG_DIR="$WINDOWS_HOME/.config/wezterm"
	WEZTERM_LUA_DIR="$WINDOWS_HOME"
fi

cp "$RIBYNS_ENV/.wezterm.lua" "$WEZTERM_LUA_DIR"

clean=false
for arg in "$@"; do
	if [[ "$arg" == "--clean" ]]; then
		clean=true
	fi
done

if [[ "$clean" == "true" ]]; then
	echo "Cleaning up wezterm config dir"
	rm -rf "$WEZTERM_CONFIG_DIR"
fi

mkdir -p "$WEZTERM_CONFIG_DIR/wallpapers"
cp "$RIBYNS_ENV/images/wallpapers/"* "$WEZTERM_CONFIG_DIR/wallpapers/"

# copy .config/wezterm content (excluding my-workspaces.lua)
mkdir -p "$WEZTERM_CONFIG_DIR"
for file in "$RIBYNS_ENV/.config/wezterm"/*; do
	if [[ "$(basename "$file")" != "my-workspaces.lua" ]]; then
		cp -r "$file" "$WEZTERM_CONFIG_DIR/"
	fi
done

motions_dir="$RIBYNS_ENV/images/motions"
if [[ -d $motions_dir ]]; then
	mkdir -p "$WEZTERM_CONFIG_DIR/motions"
	cp "$RIBYNS_ENV/images/motions/"* "$WEZTERM_CONFIG_DIR/motions/"
else
	source "$RIBYNS_ENV/scripts/utils.sh"
	warn "No motions found in $motions_dir"
	info "Motions are found in the branches named 'motions*'"
fi
