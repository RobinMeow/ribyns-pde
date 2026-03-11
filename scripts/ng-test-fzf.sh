#!/usr/bin/env bash
set -euo pipefail
clear

# Configuration
CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/ribyns-pde"
HISTORY_FILE="$CACHE_DIR/ng_test_fzf_history"
BROWSER="ChromiumHeadless"
WATCH_MODE=true
SINGLE_MODE=false

mkdir -p "$CACHE_DIR"
touch "$HISTORY_FILE"

# --- Argument Parsing ---
while [[ $# -gt 0 ]]; do
	case $1 in
	--browsers)
		BROWSER="${2:-ChromeHeadless}"
		shift 2
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

# --- Execution ---
clear
echo "▶ Running Angular specs"
echo "--------------------------------------"

npx ng test \
	--browsers "$BROWSER" \
	--watch "$WATCH_MODE" \
	$INCLUDE_FLAGS
