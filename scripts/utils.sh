#!/usr/bin/env bash

# Colored outputs
RED="\033[0;31m"
YELLOW="\033[1;33m"
GREEN="\033[0;32m"
BLUE="\033[0;34m"
GRAY="\033[0;90m"
NC="\033[0m" # No Color

error() {
	echo -e "${RED}[ERROR] $*${NC}"
}
warn() {
	echo -e "${YELLOW}[WARN] $*${NC}"
}
success() {
	echo -e "${GREEN}[SUCCESS] $*${NC}"
}
info() {
	if [[ "${RIBYNS_PDE_LOG_INFO:-false}" =~ ^(true|1|yes)$ ]]; then
		echo -e "${BLUE}[INFO] $*${NC}"
	fi
}
verbose() {
	if [[ "${RIBYNS_PDE_LOG_VERBOSE:-false}" =~ ^(true|1|yes)$ ]]; then
		echo -e "${GRAY}[VERBOSE] $*${NC}"
	fi
}
