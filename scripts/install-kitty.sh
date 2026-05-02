#!/usr/bin/env bash

set -u
source "$RIBYNS_ENV/scripts/run_on_distro.sh"

run_on_arch sudo pacman -S --needed --noconfirm kitty
run_on_fedora sudo dnf install -y kitty

mkdir -p "$HOME/.config/kitty"
cp -r "$RIBYNS_ENV/config/kitty/"* "$HOME/.config/kitty/"

# NOTE: wsl is not as fast as native.
# so im using a throttled kitty perf
source "$RIBYNS_ENV/scripts/detect_env.sh"
source "$RIBYNS_ENV/scripts/utils.sh"
detect_env
if [[ "$OS_TYPE" == "wsl" ]]; then
	cat >>"$HOME/.config/kitty/kitty.conf" <<EOF

# WSL Specific Changes
font_size 11
repaint_delay 100
input_delay 5
sync_to_monitor no
EOF
	warn "Kitty: WSL specific config has been appended."
	verbose "font_size 11"
	verbose "repaint_delay 100"
	verbose "input_delay 5"
	verbose "sync_to_monitor no"
fi
