#!/usr/bin/env bash

PDE="${PDE:-$HOME/ribyns-pde}"
source "$PDE/scripts/utils.sh"

EMAIL="$1"

if [[ -z "$EMAIL" ]]; then
	error "Email is required as the first argument"
	exit 1
fi

ssh-keygen -t rsa -b 4096 -C "$EMAIL"
ssh-keyscan -H github.com >>~/.ssh/known_hosts
