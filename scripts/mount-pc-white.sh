PDE="${PDE:-$HOME/ribyns-pde}"
"$PDE/scripts/pacman-S.sh" ntfs-3g
# TODO: move to pacman-core.sh

sudo mkdir -p /mnt/c -- main windows
sudo mkdir -p /mnt/d -- arbitrary installs
sudo mkdir -p /mnt/e -- personal drive

sudo mount -t ntfs /dev/nvme0n1p5 /mnt/c
sudo mount -t ntfs /dev/nvme0n1p4 /mnt/d
sudo mount -t ntfs /dev/nvme0n1p3 /mnt/e
