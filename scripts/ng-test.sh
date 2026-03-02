#!/usr/bin/env bash
set -euo pipefail

clear
# Configuration
HISTORY_FILE=".test_history"
HISTORY_LIMIT=5
BROWSER="ChromeHeadless"
SPEC_PATTERN=""
WATCH_MODE=true # Default to true

# Ensure history file exists
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
if [[ -z "$SPEC_PATTERN" ]]; then
	if command -v fzf >/dev/null 2>&1; then
		HEADER_MSG="Enter spec name (**/ will be prepended and .spec.ts appended)
Example: 'dashboard-view' for a single file or 'shared/table/**/*' for a module"

		FZF_OUT=$(cat "$HISTORY_FILE" | fzf \
			--height 10 \
			--reverse \
			--header "$HEADER_MSG" \
			--print-query || true)

		if [[ -z "$FZF_OUT" ]]; then
			echo "✖ Cancelled"
			exit 0
		fi

		TYPED=$(echo "$FZF_OUT" | sed -n '1p')
		SELECTED=$(echo "$FZF_OUT" | sed -n '2p')
		SPEC_PATTERN="${SELECTED:-$TYPED}"
	else
		echo "Enter spec name (**/ will be prepended and .spec.ts appended):"
		read -r SPEC_PATTERN
	fi
fi

# Validation
if [[ -z "$SPEC_PATTERN" ]]; then
	echo "✖ Spec name required"
	exit 1
fi

# Save the successful pattern to history
update_history "$SPEC_PATTERN"

# --- Output Info ---
clear
echo "▶ Running Angular specs"
echo "  Browsers: $BROWSER"
echo "  Watch:    $WATCH_MODE"
echo "  Include:  **/$SPEC_PATTERN.spec.ts"
echo "--------------------------------------"

npx ng test \
	--browsers "$BROWSER" \
	--watch "$WATCH_MODE" \
	--include "**/${SPEC_PATTERN}.spec.ts"
