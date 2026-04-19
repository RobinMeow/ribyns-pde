#!/usr/bin/env bash

clone_repo() {
	local url="$1"
	local target="$2"

	if [ ! -d "$target" ]; then
		git clone "$url" "$target"
		info "Cloned $url"
	else
		echo "Skipped clone (already exists): $target"
	fi
}
