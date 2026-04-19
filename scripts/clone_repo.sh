#!/usr/bin/env bash

clone_repo() {
	source "$PDE/scripts/utils.sh"

	# expect last arg to be a destination dir
	local dest_dir="${@: -1}"

	if [ ! -d "$dest_dir" ]; then
		git clone "$@"
		info "git clone $*"
	else
		verbose "git repository already exists. skipped \`git clone $*\`"
	fi
}
