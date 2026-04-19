#!/usr/bin/env bash

# Stopwatch utility for timing operations
# Usage: start "name", stamp "name", stop "name"
#
# Enable with: export RIBYNS_STOPWATCH_ENABLED=true
# Disable with: unset RIBYNS_STOPWATCH_ENABLED

# Global associative array to store stopwatch data
declare -gA _STOPWATCH_DATA

# Check if stopwatch is enabled
_is_stopwatch_enabled() {
	case "${RIBYNS_STOPWATCH_ENABLED}" in
	true | 1 | yes)
		return 0
		;;
	*)
		return 1
		;;
	esac
}

# Internal: Start a stopwatch with the given name
_start() {
	local name="$1"
	if [[ -z "$name" ]]; then
		echo "Error: stopwatch name is required" >&2
		return 1
	fi

	_STOPWATCH_DATA["${name}_start_time"]=$(date +%s.%N)
	_STOPWATCH_DATA["${name}_running"]="true"
}

# Public: Start a stopwatch (only if enabled)
start() {
	if _is_stopwatch_enabled; then
		_start "$@"
	fi
}

# Internal: Print the current elapsed time for the given named watch
_stamp() {
	local name="$1"
	if [[ -z "$name" ]]; then
		echo "Error: stopwatch name is required" >&2
		return 1
	fi

	local start_time="${_STOPWATCH_DATA[${name}_start_time]}"
	if [[ -z "$start_time" ]]; then
		echo "Error: stopwatch '$name' not started" >&2
		return 1
	fi

	local current_time=$(date +%s.%N)
	local elapsed=$(echo "$current_time - $start_time" | bc)

	# Format the elapsed time nicely
	local formatted
	if (($(echo "$elapsed < 1" | bc -l))); then
		formatted=$(printf "%.3fs" "$elapsed")
	else
		formatted=$(printf "%.2fs" "$elapsed")
	fi

	echo "${name}: ${formatted}"
}

# Public: Print current elapsed time (only if enabled)
stamp() {
	if _is_stopwatch_enabled; then
		_stamp "$@"
	fi
}

# Internal: Stop a stopwatch and print the total elapsed time
_stop() {
	local name="$1"
	if [[ -z "$name" ]]; then
		echo "Error: stopwatch name is required" >&2
		return 1
	fi

	local start_time="${_STOPWATCH_DATA[${name}_start_time]}"
	if [[ -z "$start_time" ]]; then
		echo "Error: stopwatch '$name' not started" >&2
		return 1
	fi

	if [[ "${_STOPWATCH_DATA[${name}_running]}" != "true" ]]; then
		echo "Error: stopwatch '$name' is not running" >&2
		return 1
	fi

	local end_time=$(date +%s.%N)
	local elapsed=$(echo "$end_time - $start_time" | bc)

	# Format the elapsed time nicely
	local formatted
	if (($(echo "$elapsed < 1" | bc -l))); then
		formatted=$(printf "%.3fs" "$elapsed")
	else
		formatted=$(printf "%.2fs" "$elapsed")
	fi

	# Mark as stopped and store the final elapsed time
	_STOPWATCH_DATA["${name}_running"]="false"
	_STOPWATCH_DATA["${name}_elapsed"]="$elapsed"

	echo "⏱️  ${name}: ${formatted}"
}

# Public: Stop a stopwatch (only if enabled)
stop() {
	if _is_stopwatch_enabled; then
		_stop "$@"
	fi
}

# Export all public functions
export -f start stamp stop
export -f _start _stamp _stop

# NOTE: this is the prompt i used to generate the file
# note that i made manual changes afterwards
# but it worked great out of the box
#
# #{buffer} @{agent} i want
# the todo to be done.
# use the file `$HOME/ribyns-pde/scripts/stopwatch.sh`
# it should expose functions when sourced:
# `_start`
# `start`
# `_stamp`
# `stamp`
# `stop`
# `_stop`
# each function takes in a stringly typed name.
# invokation could look like this:
# `start "wezterm"`
# `stamp "wezterm"`
# `stop "wezterm"`
# start: starts the timer for the given named watch
# stamp: print the current time for the given named watch
# stop: stops the timer for the given named watch and prints the timer for it
#
# the difference between with underscore `_` and without is that
# the one without will invoke the one with underscore `_` but only
# if `RIBYNS_STOPWATCH_ENABLED` is set to `true` `1` or `yes`.
#
# maybe i forgoet something feel free to be creative
