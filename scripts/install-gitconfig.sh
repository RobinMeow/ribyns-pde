#!/usr/bin/env bash

set -u

# overide the entries for core and advice
# Not a real migration. If a previous version of ribyns-env had values and are not deleted
# they wont be removed
# new ones will be added
# existing ones overidden
git config --file "$RIBYNS_ENV/.gitconfig" --get-regexp '^(core|advice|pull|push)\.' | while read -r key value; do
	git config --global "$key" "$value"
done

# discard all aliases
git config --global --remove-section alias 2>/dev/null

# re-add them all
git config --file "$RIBYNS_ENV/.gitconfig" --get-regexp '^alias\.' | while read -r key value; do
	key="${key#alias.}"
	git config --global alias."$key" "$value"
done
