#!/usr/bin/env bash
set -euo pipefail # -e exit on error, -u undefined variables are errors, -o pipefail pipelines fails if any command fails not just last one

# Usage:
#   ./scripts/ng-test.sh [browser] [spec-name]
#
# Examples:
#   ./scripts/ng-test.sh Chrome user-form

# TODO: allow spec pattern as first argument
# TODO: add picker for previously typed patterns
BROWSER="${1:-ChromeHeadless}"


if [[ $# -ge 2 ]]; then
  SPEC_PATTERN="$2"
else
  # interactively prompt
  echo "Enter spec name (**/ will be prepended and .spec.ts appended)"
  echo "type 'dashboard-view' to test a single file '**/dashboard-view.spec.ts' or 'shared/table/**/*' to test a whole module"
  read -r SPEC_PATTERN

  # validation
  if [[ -z "$SPEC_PATTERN" ]]; then
    echo "❌ Spec name required"
    edit 1;
  fi
fi

echo "▶ Running Angular specs"
echo "  Browsers: $BROWSER"
echo "  Include:    **/$SPEC_PATTERN.spec.ts"

npx ng test \
  --browsers "$BROWSER" \
  --watch true \
  --include "**/${SPEC_PATTERN}.spec.ts"

