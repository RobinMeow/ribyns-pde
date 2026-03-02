#!/usr/bin/env bash
set -euo pipefail

# Configuration
HISTORY_FILE=".test_history"
HISTORY_LIMIT=4
BROWSER="${1:-ChromeHeadless}"

# Ensure history file exists
touch "$HISTORY_FILE"

# Function to update history (removes duplicates and keeps it fresh)
update_history() {
	local pattern=$1
	# Remove the pattern if it exists, prepend it to the top, and trim to limit
	(
		echo "$pattern"
		grep -vF "$pattern" "$HISTORY_FILE" || true
	) | head -n "$HISTORY_LIMIT" >"${HISTORY_FILE}.tmp"
	mv "${HISTORY_FILE}.tmp" "$HISTORY_FILE"
}

# Logic to determine the SPEC_PATTERN
if [[ $# -ge 2 ]]; then
	SPEC_PATTERN="$2"
else
	echo "--- Recent Patterns ---"
	# Use 'cat -n' to show numbered history
	if [ -s "$HISTORY_FILE" ]; then
		cat -n "$HISTORY_FILE"
		echo "-----------------------"
		echo "Enter a number, a new pattern, or leave blank for the latest [1]:"
	else
		echo "No history yet."
		echo "Enter spec name (e.g., 'user-form' or 'shared/table/**/*'):"
	fi

	read -r INPUT

	if [[ -z "$INPUT" ]]; then
		# Default to the most recent entry if it exists
		SPEC_PATTERN=$(head -n 1 "$HISTORY_FILE")
	elif [[ "$INPUT" =~ ^[0-9]+$ ]]; then
		# If input is a number, pick that line from history
		SPEC_PATTERN=$(sed -n "${INPUT}p" "$HISTORY_FILE")
	else
		# Otherwise, it's a brand new pattern
		SPEC_PATTERN="$INPUT"
	fi
fi

# Validation
if [[ -z "$SPEC_PATTERN" ]]; then
	echo "✖ Spec name required"
	exit 1
fi

# Save the successful pattern
update_history "$SPEC_PATTERN"

echo "▶ Running Angular specs"
echo "  Browsers: $BROWSER"
echo "  Include:  **/$SPEC_PATTERN.spec.ts"

npx ng test \
	--browsers "$BROWSER" \
	--watch true \
	--include "**/${SPEC_PATTERN}.spec.ts"
