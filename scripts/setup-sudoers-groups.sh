#!/bin/bash

# Script to create a sudoers configuration file for admin groups
# This script must be run as root.

if [ "$EUID" -ne 0 ]; then
	echo "Please run as root"
	exit 1
fi

DEST_FILE="/etc/sudoers.d/admin-groups"

echo "Creating sudoers configuration at $DEST_FILE..."

cat <<EOF >"$DEST_FILE"
# Allow members of group wheel to execute any command
%wheel ALL=(ALL:ALL) ALL

# Allow members of group sudo to execute any command
%sudo ALL=(ALL:ALL) ALL
EOF

chmod 440 "$DEST_FILE"
chown root:root "$DEST_FILE"

echo "Successfully created and configured $DEST_FILE"
