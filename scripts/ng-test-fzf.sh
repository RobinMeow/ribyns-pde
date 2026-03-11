#!/usr/bin/env bash
set -euo pipefail

# Configuration
CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/ribyns-pde"
HISTORY_FILE="$CACHE_DIR/ng_test_fzf_history"
BROWSER="chromiumheadless"
WATCH_MODE=true
SINGLE_MODE=false

show_help() {
	echo "Usage: $(basename "$0") [QUERY] [OPTIONS]"
	echo ""
	echo "Options:"
	echo "  -h, --help      Show this help message"
	echo "  --karma         Use ChromeHeadless (default: chromiumheadless)"
	echo "  --browsers      Specify a custom browser engine"
	echo "  --no-watch      Disable watch mode"
	echo "  --single        Single selection mode (disables 'select-all' on Enter)"
	echo ""
	echo "Arguments:"
	echo "  QUERY           Initial filter string for fzf"
	exit 0
}

# --- Argument Parsing ---
while [[ $# -gt 0 ]]; do
	case $1 in
	-h | --help)
		show_help
		;;
	--browsers)
		BROWSER="${2:-chromiumheadless}"
		shift 2
		;;
	--karma)
		BROWSER="ChromeHeadless"
		shift
		;;
	--no-watch)
		WATCH_MODE=false
		shift
		;;
	--single)
		SINGLE_MODE=true
		shift
		;;
	*)
		QUERY="$1"
		shift
		;;
	esac
done

clear
mkdir -p "$CACHE_DIR"
touch "$HISTORY_FILE"

# --- File Discovery ---
# Get all spec/test files, relative to current dir
mapfile -t ALL_SPECS < <(find . -type f \( -name "*.spec.ts" -o -name "*.test.ts" \) -not -path "*/node_modules/*" | sed 's|^\./||')

if [ ${#ALL_SPECS[@]} -eq 0 ]; then
	echo "No spec files found."
	exit 1
fi

# --- FZF Logic ---
# Logic: If --single, just return the selection.
# If NOT single, we bind 'enter' to select-all + accept so all filtered items are returned.
if [[ "$SINGLE_MODE" == true ]]; then
	FZF_BIND=""
	HEADER_MSG="SINGLE MODE: Select one file to test"
else
	# This magic string selects all matches currently visible and then accepts
	FZF_BIND="--bind 'enter:select-all+accept'"
	HEADER_MSG="BATCH MODE: Press Enter to run ALL filtered results | Tab to multi-select"
fi

FZF_OUT=$(printf "%s\n" "${ALL_SPECS[@]}" | eval fzf \
	$FZF_BIND \
	--height 40% \
	--reverse \
	--multi \
	--header \"$HEADER_MSG\" \
	--query \"${QUERY:-}\" \
	--history \"$HISTORY_FILE\")

if [[ -z "$FZF_OUT" ]]; then
	echo "✖ Cancelled"
	exit 0
fi

# --- Formatting the flags ---
# Prepend --include to each selected file
INCLUDE_FLAGS=$(echo "$FZF_OUT" | sed 's|^|--include |' | tr '\n' ' ')

# Strip paths and all suffixes (e.g., path/file.spec.ts -> file)
# BASENAMES=$(echo "$FZF_OUT" | sed 's|.*/||; s|\..*||' | paste -sd ", " -)
BASENAMES=$(echo "$FZF_OUT" | sed 's|.*/||; s|\..*||' | paste -sd, - | sed 's/,/, /g')

# --- Execution ---
clear
echo "▶ Running Angular specs"
echo "  Files: ${BASENAMES}"
echo "--------------------------------------"

npx ng test \
	--browsers "$BROWSER" \
	--watch "$WATCH_MODE" \
	$INCLUDE_FLAGS
