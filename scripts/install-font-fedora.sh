#!/usr/bin/env bash

# https://docs.fedoraproject.org/en-US/quick-docs/fonts/#unpackaged

set -u
source "$PDE/scripts/run_on_distro.sh"

run_on_fedora dnf install -y unzip

dest="/usr/local/share/fonts/commit-mono"
sudo mkdir -p $dest
sudo unzip "$HOME/Downloads/CommitMono.zip" $dest

# Permissions
sudo chown -R root: $dest
sudo chmod 644 "$dest"*
sudo restorecon -vFr $dest

# update font cache
sudo fc-cache -v
