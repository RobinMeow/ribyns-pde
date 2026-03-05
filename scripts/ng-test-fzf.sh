#!/usr/bin/env bash
set -euo pipefail
clear

# Configuration
CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/ribyns-pde"
HISTORY_FILE="$CACHE_DIR/ng_test_fzf_history"
HISTORY_LIMIT=10
BROWSER="ChromeHeadless"
WATCH_MODE=true
SINGLE_MODE=false
SELECTED_FILES=""

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
		# Treat any other arg as a starting query for fzf
		QUERY="$1"
		shift
		;;
	esac
done

# --- Helper: Update History ---
update_history() {
	local entry="$1"
	[[ -z "$entry" ]] && return
	(
		echo "$entry"
		grep -vF "$entry" "$HISTORY_FILE" || true
	) | head -n "$HISTORY_LIMIT" >"${HISTORY_FILE}.tmp"
	mv "${HISTORY_FILE}.tmp" "$HISTORY_FILE"
}

# --- File Discovery & FZF ---
# Scan for .spec.ts and .test.ts files
mapfile -t ALL_SPECS < <(find . -type f \( -name "*.spec.ts" -o -name "*.test.ts" \) -not -path "*/node_modules/*" | sed 's|^\./||')

if [ ${#ALL_SPECS[@]} -eq 0 ]; then
	echo "Folder is empty of specs. Exiting."
	exit 1
fi

# Run FZF
# We use --query to pass any initial argument from the CLI
FZF_OUT=$(printf "%s\n" "${ALL_SPECS[@]}" | fzf \
	--height 40% \
	--reverse \
	--header "Enter to test filtered list | --single: closest match only" \
	--history "$HISTORY_FILE" \
	--query "${QUERY:-}" \
	--multi || true)

if [[ -z "$FZF_OUT" && -n "${QUERY:-}" ]]; then
	# If user typed something but nothing matched/selected,
	# and they didn't hit escape, we treat as empty (run all).
	# But usually, if FZF_OUT is empty, user hit ESC.
	echo "✖ Cancelled"
	exit 0
fi

# --- Logic: Single vs Filtered List ---
if [[ "$SINGLE_MODE" == true ]]; then
	# Take the top match from the filtered list (or the selection)
	SELECTED_FILES=$(echo "$FZF_OUT" | head -n 1)
else
	# Use the entire filtered list returned by fzf
	# Replace newlines with single-quoted strings for the --include array
	SELECTED_FILES=$(echo "$FZF_OUT" | sed "s/.*/'&'/" | paste -sd "," -)
fi

# Update history with the first item selected
FIRST_MATCH=$(echo "$FZF_OUT" | head -n 1)
update_history "$FIRST_MATCH"

# --- Execution ---
clear
echo "▶ Running Angular specs (FZF Mode)"
echo "  Browsers: $BROWSER"
echo "  Watch:    $WATCH_MODE"
echo "  Mode:     $([[ "$SINGLE_MODE" == true ]] && echo "Single" || echo "Batch")"

if [[ -z "$SELECTED_FILES" ]]; then
	echo "  Include:  All specs (Default)"
	INCLUDE_ARG="['**/*.spec.ts', '**/*.test.ts']"
else
	echo "  Include:  $SELECTED_FILES"
	INCLUDE_ARG="[$SELECTED_FILES]"
fi
echo "--------------------------------------"

npx ng test \
	--browsers "$BROWSER" \
	--watch "$WATCH_MODE" \
	--include "$INCLUDE_ARG"
