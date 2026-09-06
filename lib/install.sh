#!/usr/bin/env bash
set -euo pipefail

mkdir -p "$HOME/.local/state/ribyn/"
logfile="$HOME/.local/state/ribyn/rin.log"
# Append to file and print to terminal simultaneously
# use --append flag if you want to append, instead of override
exec > >(tee "$logfile") 2>&1

source "$RIBYN_ROOT/core/utils.sh"
source "$RIBYN_ROOT/core/run_on_distro.sh"

info "Installing from source: $RIBYN_ROOT"

"$RIBYN_ROOT/lib/install-essentials-packages.sh"

# WARN: uses brew. and brew resets sudo timestamp.
# means we have to re-prompt our pw. I'd rather do it earlier
# than later so I can afk after.
"$RIBYN_ROOT/lib/yazi/install.sh"

"$RIBYN_ROOT/lib/install-core-packages.sh"
"$RIBYN_ROOT/lib/zsh/install.sh"
"$RIBYN_ROOT/lib/install-no-tofu.sh"
"$RIBYN_ROOT/lib/kaomoji/install.sh"
"$RIBYN_ROOT/lib/catppuccin-cursors/install.sh"
"$RIBYN_ROOT/lib/qt6ct/install.sh"
"$RIBYN_ROOT/lib/install-commit-mono.sh"
"$RIBYN_ROOT/lib/brave/install.sh"
"$RIBYN_ROOT/lib/firefox/install.sh"
"$RIBYN_ROOT/lib/thunderbird/install.sh"
"$RIBYN_ROOT/lib/bat/install.sh"
"$RIBYN_ROOT/lib/btop/install.sh"
"$RIBYN_ROOT/lib/kitty/install.sh"
"$RIBYN_ROOT/lib/wezterm/install.sh"
"$RIBYN_ROOT/lib/nvim/install.sh"
"$RIBYN_ROOT/lib/vale/install.sh"
"$RIBYN_ROOT/lib/tmux/install.sh"
"$RIBYN_ROOT/lib/wiremix/install.sh"
"$RIBYN_ROOT/lib/mpd/install.sh"
"$RIBYN_ROOT/lib/rmpc/install.sh"
"$RIBYN_ROOT/lib/zathura/install.sh"
"$RIBYN_ROOT/lib/bluetui/install.sh"
"$RIBYN_ROOT/lib/rofi/install.sh"
"$RIBYN_ROOT/lib/wayland/install-screenshot-tools.sh"
"$RIBYN_ROOT/lib/wl-freeze/install.sh"
"$RIBYN_ROOT/lib/waybar/install.sh"
"$RIBYN_ROOT/lib/wayscriber/install.sh"
"$RIBYN_ROOT/lib/dunst/install.sh"
"$RIBYN_ROOT/lib/mpvpaper/install.sh"
"$RIBYN_ROOT/lib/wob/install.sh"
"$RIBYN_ROOT/lib/i3/install.sh"
"$RIBYN_ROOT/lib/signal/install.sh"
"$RIBYN_ROOT/lib/hypr/install.sh"
"$RIBYN_ROOT/lib/kde/install.sh"
"$RIBYN_ROOT/lib/xdg-desktop-portal-termfilechooser/install.sh"
"$RIBYN_ROOT/lib/install-gadget-packages.sh"

success "ribynliniux installed"
