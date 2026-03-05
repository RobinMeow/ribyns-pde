#!/usr/bin/env bash
set -euo pipefail

clear
# Configuration
CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/ribyns-pde"
HISTORY_FILE="$CACHE_DIR/ng_test_fzf"
HISTORY_LIMIT=5
BROWSER="ChromeHeadless"
WATCH_MODE=true
SINGLE_MODE=false

mkdir -p "$CACHE_DIR"
touch "$HISTORY_FILE"

# --- Argument Parsing ---
while [[ $# -gt 0 ]]; do
	case $1 in
	--browsers)
		BROWSER="${2:?Error: --browsers requires a value}"
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
		echo "Unknown argument: $1"
		exit 1
		;;
	esac
done

# --- File Selection Logic ---
# Get list of all spec files
ALL_SPECS=$(find . -name "*.spec.ts" -not -path "*/node_modules/*" | sed 's|^\./||')

if [[ -z "$ALL_SPECS" ]]; then
	echo "✖ No .spec.ts files found in current directory."
	exit 1
fi

FZF_OPTS=(
	--height 15
	--reverse
	--header "TAB to multi-select | Enter to finish | Esc to cancel"
	--print-query
)

# If --single is NOT set, enable multi-select
[[ "$SINGLE_MODE" = false ]] && FZF_OPTS+=(--multi)

# Use history as suggestions via a preview or header if preferred,
# but here we focus on the file list.
FZF_OUT=$(echo "$ALL_SPECS" | fzf "${FZF_OPTS[@]}" || true)

if [[ -z "$FZF_OUT" ]]; then
	echo "✖ Cancelled"
	exit 0
fi

QUERY=$(echo "$FZF_OUT" | sed -n '1p')
# Get all lines except the first (the query)
SELECTED_FILES=$(echo "$FZF_OUT" | sed '1d')

# --- Logic: If query exists but nothing selected, filter ALL_SPECS by that query ---
if [[ -n "$QUERY" && -z "$SELECTED_FILES" ]]; then
	# Use fzf's own filtering logic to mimic glob/fuzzy matching on the whole list
	SELECTED_FILES=$(echo "$ALL_SPECS" | fzf --filter="$QUERY" || true)
fi

# Final check: If still empty (user just hit enter on empty search), run all.
# If --single is on, we ensure only the first selection is used.
if [[ "$SINGLE_MODE" = true ]]; then
	SELECTED_FILES=$(echo "$SELECTED_FILES" | head -n 1)
fi

# --- Build Command ---
CMD_ARGS=(--browsers "$BROWSER" --watch "$WATCH_MODE")

# Construct --include flags for each file
if [[ -n "$SELECTED_FILES" ]]; then
	while read -r file; do
		[[ -n "$file" ]] && CMD_ARGS+=(--include "$file")
	done <<<"$SELECTED_FILES"
fi

# --- Output Info ---
clear
echo "▶ Running Angular specs (FZF Mode)"
echo "  Browsers: $BROWSER"
echo "  Watch:    $WATCH_MODE"
echo "  Files:    ${SELECTED_FILES:-All specs}"
echo "--------------------------------------"

npx ng test "${CMD_ARGS[@]}"
