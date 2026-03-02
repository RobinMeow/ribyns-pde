#!/usr/bin/env bash
set -euo pipefail

# Configuration
HISTORY_FILE=".test_history"
HISTORY_LIMIT=10
BROWSER="${1:-ChromeHeadless}"

# Ensure history file exists
touch "$HISTORY_FILE"

# Function to update history
update_history() {
	local pattern=$1
	(
		echo "$pattern"
		grep -vF "$pattern" "$HISTORY_FILE" || true
	) | head -n "$HISTORY_LIMIT" >"${HISTORY_FILE}.tmp"
	mv "${HISTORY_FILE}.tmp" "$HISTORY_FILE"
}

# --- Logic to determine the SPEC_PATTERN ---
if [[ $# -ge 2 ]]; then
	SPEC_PATTERN="$2"
else
	if command -v fzf >/dev/null 2>&1; then
		# Use || true to prevent 'set -e' from exiting on empty filter
		FZF_OUT=$(cat "$HISTORY_FILE" | fzf --height 10 --reverse --header "Type new or select existing" --query "${1:-}" --print-query || true)

		if [[ -z "$FZF_OUT" ]]; then
			echo "✖ Cancelled"
			exit 0
		fi

		TYPED=$(echo "$FZF_OUT" | sed -n '1p')
		SELECTED=$(echo "$FZF_OUT" | sed -n '2p')

		# Use the selection if it exists, otherwise use what was typed
		SPEC_PATTERN="${SELECTED:-$TYPED}"
	else
		echo "fzf not found. Enter spec name:"
		read -r SPEC_PATTERN
	fi
fi

# Validation
if [[ -z "$SPEC_PATTERN" ]]; then
	echo "✖ Spec name required"
	exit 1
fi

# Save the successful pattern
update_history "$SPEC_PATTERN"

# --- Output Info (Original Style) ---
clear
echo "▶ Running Angular specs"
echo "  Browsers: $BROWSER"
echo "  Include:  **/$SPEC_PATTERN.spec.ts"
echo "--------------------------------------"

npx ng test \
	--browsers "$BROWSER" \
	--watch true \
	--include "**/${SPEC_PATTERN}.spec.ts"
