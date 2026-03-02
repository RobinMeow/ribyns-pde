#!/usr/bin/env bash
set -euo pipefail

# Configuration
HISTORY_FILE=".test_history"
HISTORY_LIMIT=5
BROWSER="${1:-ChromeHeadless}"

# Ensure history file exists
touch "$HISTORY_FILE"

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

# --- Logic to determine the SPEC_PATTERN ---
if [[ $# -ge 2 ]]; then
	SPEC_PATTERN="$2"
else
	if command -v fzf >/dev/null 2>&1; then
		# Multi-line header with your original instructions
		HEADER_MSG="Enter spec name (**/ will be prepended and .spec.ts appended)
Example: 'dashboard-view' for a single file or 'shared/table/**/*' for a module"

		FZF_OUT=$(cat "$HISTORY_FILE" | fzf \
			--height 10 \
			--reverse \
			--header "$HEADER_MSG" \
			--query "${1:-}" \
			--print-query || true)

		if [[ -z "$FZF_OUT" ]]; then
			echo "✖ Cancelled"
			exit 0
		fi

		TYPED=$(echo "$FZF_OUT" | sed -n '1p')
		SELECTED=$(echo "$FZF_OUT" | sed -n '2p')

		# Use selection if arrowed, otherwise use what was typed
		SPEC_PATTERN="${SELECTED:-$TYPED}"
	else
		# Fallback for systems without fzf
		echo "Enter spec name (**/ will be prepended and .spec.ts appended)"
		echo "Example: 'dashboard-view' or 'shared/table/**/*'"
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
echo "  Include:  **/$SPEC_PATTERN.spec.ts"
echo "--------------------------------------"

npx ng test \
	--browsers "$BROWSER" \
	--watch true \
	--include "**/${SPEC_PATTERN}.spec.ts"
