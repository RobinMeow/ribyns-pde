#!/usr/bin/env bash
set -euo pipefail

clear
# Configuration
CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/ribyns-env"
HISTORY_FILE="$CACHE_DIR/ng_test_history"
HISTORY_LIMIT=5
BROWSER="ChromeHeadless"
SPEC_PATTERN=""
WATCH_MODE=true # Default to true
RUN_ALL=false

mkdir -p "$CACHE_DIR"
touch "$HISTORY_FILE"

# --- Argument Parsing ---
while [[ $# -gt 0 ]]; do
	case $1 in
	--browsers)
		if [[ -z "${2:-}" ]]; then
			echo "Error: --browsers requires a value"
			exit 1
		fi
		BROWSER="$2"
		shift 2
		;;
	--no-watch)
		WATCH_MODE=false
		shift
		;;
	--all)
		RUN_ALL=true
		shift
		;;
	*)
		# Assume anything else is the spec pattern
		SPEC_PATTERN="$1"
		shift
		;;
	esac
done

# Function to update history
update_history() {
	local pattern=$1
	# Remove the pattern if it exists, prepend it to the top, and trim to 5
	(
		echo "$pattern"
		grep -vF "$pattern" "$HISTORY_FILE" || true
	) | head -n "$HISTORY_LIMIT" >"${HISTORY_FILE}.tmp"
	mv "${HISTORY_FILE}.tmp" "$HISTORY_FILE"
}

# --- Logic to determine the SPEC_PATTERN (Interactive if empty) ---
if [[ -z "$SPEC_PATTERN" && "$RUN_ALL" = false ]]; then
	if command -v fzf >/dev/null 2>&1; then
		HEADER_MSG="Enter spec name (**/ will be prepended and .spec.ts appended)
Example: 'dashboard-view' for a single file or 'shared/table/**/*' for a module"

		FZF_OUT=$(cat "$HISTORY_FILE" | fzf \
			--height 10 \
			--reverse \
			--no-select-1 --exit-0 \
			--header "$HEADER_MSG" \
			--print-query || true)

		if [[ -z "$FZF_OUT" ]]; then
			echo "✖ Cancelled"
			exit 0
		fi

		TYPED=$(echo "$FZF_OUT" | sed -n '1p')
		SELECTED=$(echo "$FZF_OUT" | sed -n '2p')
		# Use SELECTED if user moved the cursor, otherwise use TYPED (which could be empty)
		SPEC_PATTERN="${SELECTED:-$TYPED}"
	else
		echo "Enter spec name (**/ will be prepended and .spec.ts appended):"
		read -r SPEC_PATTERN
	fi
fi

# if pattern was provided, cache it
[[ -n "$SPEC_PATTERN" ]] && update_history "$SPEC_PATTERN"

# --- Output Info ---
clear
echo "▶ Running Angular specs"
echo "  Browsers: $BROWSER"
echo "  Watch:    $WATCH_MODE"
echo "  Include:  ${SPEC_PATTERN:-All specs}"
echo "--------------------------------------"

npx ng test \
	--browsers "$BROWSER" \
	--watch "$WATCH_MODE" \
	${SPEC_PATTERN:+--include "**/${SPEC_PATTERN}.spec.ts"}
