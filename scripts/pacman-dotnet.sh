#!/usr/bin/env bash
set -euo pipefail

PDE="${PDE:-$HOME/ribyns-pde}"
source "$PDE/scripts/utils.sh"

RIBYNS_PDE_LOG_INFO=true info "Installing .NET packages..."

"$PDE/scripts/pacman-S.sh" \
	dotnet-runtime \
	dotnet-sdk \
	aspnet-runtime \
	aspnet-targeting-pack

RIBYNS_PDE_LOG_INFO=true success ".NET packages installed"
