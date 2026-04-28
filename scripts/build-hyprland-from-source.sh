#!/usr/bin/env bash

# NOTE: wip
# https://wiki.hypr.land/Getting-Started/Installation/#cmake-recommended

set -e

source "$PDE/scripts/utils.sh"
source "$PDE/scripts/run_on_distro.sh"

run_on_arch <<'EOF'
    echo "ERROR: Use pacman on archlinux to install hyperland."
    echo "use: pacman -S hyprland"
    exit 1
EOF

# Building Hyprland on Fedora HOWTO #284 https://github.com/hyprwm/Hyprland/discussions/284

git clone --recursive https://github.com/hyprwm/Hyprland "$PDE/hyprland"
cd "$PDE/hyprland"

# NOTE: using cmake (recommended)

run_on_fedora sudo dnf install -y cmake
make all && sudo make install

# NOTE: using ninja
# run_on_fedora sudo dnf install -y ninja-build cmake meson gcc-c++ libxcb-devel libX11-devel pixman-devel wayland-protocols-devel cairo-devel pango-devel
# meson _build
# ninja -C _build
# sudo ninja -C _build install

# At this point, Hyprland will be installed. However, on my system at least, I needed to install the Hyprland.desktop session file somewhere that gdm could find it, because it appears gdm doesn't look in /usr/local/share/wayland-sessions:
# sudo cp /usr/local/share/wayland-sessions/hyprland.desktop /usr/share/wayland-sessions

mkdir -p "$HOME/.config/hypr"
if [[ -f "$HOME/.config/hypr/hyprland.conf" ]]; then
	verbose "Not using exmaple hyperland.conf (.config/hypr/hyperland.conf already exists)"
else
	cp example/hyprland.conf ~/.config/hypr
	info "Using example hyprland.conf"
fi

# copr is also available
# lionheartp/Hyprland https://copr.fedorainfracloud.org/coprs/lionheartp/Hyprland
