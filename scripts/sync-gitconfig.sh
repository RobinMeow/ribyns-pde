#!/usr/bin/env bash

PDE="$HOME/ribyns-pde/.gitconfig"

# overide the entries for core and advice
# Not a real migration. If a previous version of ribyns-pde had values and are not deleted
# they wont be removed
# new ones will be added
# existing ones overidden
git config --file "$PDE" --get-regexp '^(core|advice|pull|push)\.' | while read -r key value; do
	git config --global "$key" "$value"
done

# discard all aliases
git config --global --remove-section alias 2>/dev/null

# re-add them all
git config --file "$PDE" --get-regexp '^alias\.' | while read -r key value; do
	key="${key#alias.}"
	git config --global alias."$key" "$value"
done
