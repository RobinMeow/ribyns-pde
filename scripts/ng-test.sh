#!/usr/bin/env bash
set -euo pipefail

HISTORY_FILE=".test_history"
HISTORY_LIMIT=10
BROWSER="${1:-ChromeHeadless}"

touch "$HISTORY_FILE"

update_history() {
	local pattern=$1
	(
		echo "$pattern"
		grep -vF "$pattern" "$HISTORY_FILE" || true
	) | head -n "$HISTORY_LIMIT" >"${HISTORY_FILE}.tmp"
	mv "${HISTORY_FILE}.tmp" "$HISTORY_FILE"
}

if [[ $# -ge 2 ]]; then
	SPEC_PATTERN="$2"
else
	if command -v fzf >/dev/null 2>&1; then
		# The '|| true' prevents 'set -e' from killing the script if no match is found
		FZF_OUT=$(cat "$HISTORY_FILE" | fzf --height 10 --reverse --header "Type new or select existing" --query "${1:-}" --print-query || true)

		# If FZF_OUT is empty (user hit ESC), exit gracefully
		if [[ -z "$FZF_OUT" ]]; then
			echo "✖ Cancelled"
			exit 0
		fi

		# Get the first line (what you typed) and the last line (the selection)
		# Using 'sed' to ensure we handle the multi-line output correctly
		TYPED=$(echo "$FZF_OUT" | sed -n '1p')
		SELECTED=$(echo "$FZF_OUT" | sed -n '2p')

		# If you selected an item with arrows, use it.
		# Otherwise, use exactly what you typed.
		SPEC_PATTERN="${SELECTED:-$TYPED}"
	else
		echo "fzf not found. Enter spec name:"
		read -r SPEC_PATTERN
	fi
fi

update_history "$SPEC_PATTERN"

echo "▶ Running Angular specs"
echo "  Browsers: $BROWSER"
echo "  Include:  **/$SPEC_PATTERN.spec.ts"

npx ng test \
	--browsers "$BROWSER" \
	--watch true \
	--include "**/${SPEC_PATTERN}.spec.ts"
