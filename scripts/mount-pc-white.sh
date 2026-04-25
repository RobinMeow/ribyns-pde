#!/usr/bin/env bash
source "$PDE/scripts/utils.sh"
assert_pde_vars

source "$PDE/scripts/dispatch-distro.sh"

dispatch_arch sudo pacman -S --needed --noconfirm ntfs-3g
dispatch_fedora sudo dnf install -y ntfs-3g

sudo mkdir -p /mnt/c -- main windows
sudo mkdir -p /mnt/d -- arbitrary installs
sudo mkdir -p /mnt/e -- personal drive

sudo mount -t ntfs /dev/nvme0n1p5 /mnt/c
sudo mount -t ntfs /dev/nvme0n1p4 /mnt/d
sudo mount -t ntfs /dev/nvme0n1p3 /mnt/e
