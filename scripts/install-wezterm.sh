#!/usr/bin/env bash
source "$PDE/scripts/utils.sh"
assert_pde_vars

case "$OSD_DISTRIBUTION" in
arch)
	sudo pacman -S --needed --noconfirm wezterm
	;;
fedora)
	sudo dnf install -y wezterm
	;;
*)
	warn "Distro '$OSD_DISTRIBUTION' not supported for installing wezterm"
	;;
esac

WEZTERM_CONFIG_DIR="$HOME/.config/wezterm"
source "$PDE/scripts/detect_env.sh"
detect_env

if [[ "$OS_TYPE" == "wsl" ]]; then
	source "$PDE/scripts/detect_win_user.sh"
	detect_win_user

	WEZTERM_CONFIG_DIR="$WINDOWS_HOME/.config/wezterm"
	WEZTERM_LUA_DIR="$WINDOWS_HOME"

	cp "$PDE/.wezterm.lua" "$WEZTERM_LUA_DIR"
else
	cp "$PDE/.wezterm.lua" "$WEZTERM_LUA_DIR"
fi

if [[ "$1" == "--clean" ]]; then
	echo "Cleaning up wezterm config dir"
	rm -rf "$WEZTERM_CONFIG_DIR"
fi

mkdir -p "$WEZTERM_CONFIG_DIR/wallpapers"
cp "$PDE/images/wallpapers/"* "$WEZTERM_CONFIG_DIR/wallpapers/"

# copy .config/wezterm content (excluding my-workspaces.lua)
mkdir -p "$WEZTERM_CONFIG_DIR"
for file in "$PDE/.config/wezterm"/*; do
	if [[ "$(basename "$file")" != "my-workspaces.lua" ]]; then
		cp -r "$file" "$WEZTERM_CONFIG_DIR/"
	fi
done

motions_dir="$PDE/images/motions"
if [[ -d $motions_dir ]]; then
	mkdir -p "$WEZTERM_CONFIG_DIR/motions"
	cp "$PDE/images/motions/"* "$WEZTERM_CONFIG_DIR/motions/"
else
	source "$PDE/scripts/utils.sh"
	warn "No motions found in $motions_dir"
	info "Motions are found in the branches named 'motions*'"
fi
