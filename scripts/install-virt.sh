#!/usr/bin/env bash

set -u
source "$PDE/scripts/run_on_distro.sh"

run_on_arch sudo pacman -S --needed --noconfirm libvirt virt-manager virt-viewer qemu-full dmidecode dnsmasq openbsd-netcat
run_on_fedora sudo dnf install -y @virtualization

# mkdir -p "$HOME/.config/bat"
# cp -r "$PDE/.config/bat/"* "$HOME/.config/bat/"
