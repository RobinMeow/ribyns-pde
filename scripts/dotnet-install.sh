#!/usr/bin/env bash

set -e

# URL of the official Microsoft .NET install script
DOTNET_INSTALL_URL="https://dot.net/v1/dotnet-install.sh"

# create tmp file
TMP_SCRIPT="$(mktemp)"
# Ensure cleanup always runs
trap 'rm -f "$TMP_SCRIPT"' EXIT

echo "Downloading .NET install script..."
# Download the script to a temporary file
curl -fsSL "$DOTNET_INSTALL_URL" -o "$TMP_SCRIPT"

chmod +x "$TMP_SCRIPT"

echo "Running install script with arguments: $*"

# Execute the script, forwarding all arguments
"$TMP_SCRIPT" "$@"
