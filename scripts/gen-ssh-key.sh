#!/usr/bin/env bash

source "$PDE/scripts/utils.sh"

EMAIL="$1"

if [[ -z "$EMAIL" ]]; then
	error "Email is required as the first argument"
	exit 1
fi

ssh-keygen -t rsa -b 4096 -C "$EMAIL"
ssh-keyscan -H github.com >>~/.ssh/known_hosts
ssh-keyscan -H codeberg.org >>~/.ssh/known_hosts
