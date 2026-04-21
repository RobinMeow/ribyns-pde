#!/bin/zsh

# Zsh-only Stopwatch Utility
# Optimized for Zsh floating-point math. No 'bc' or 'awk' required.

# Use a global associative array
typeset -gA _STOPWATCH_DATA

_is_stopwatch_enabled() {
	[[ "$RIBYNS_STOPWATCH_ENABLED" =~ ^(true|1|yes)$ ]]
}

# Internal: Formats seconds into a clean string
_format_time() {
	local elapsed=$1
	local name=$2
	local prefix=$3

	# Zsh printf handles floats natively
	local formatted
	if ((elapsed < 1)); then
		formatted=$(printf "%.3fs" "$elapsed")
	else
		formatted=$(printf "%.2fs" "$elapsed")
	fi

	echo -e "${prefix}${name}: ${formatted}"
}

_start() {
	local name="$1"
	[[ -z "$name" ]] && return 1

	# SECONDS is a built-in Zsh variable, but for precision
	# we use the 'zsh/datetime' module if available, or just 'date'
	zmodload zsh/datetime 2>/dev/null

	if (($+functions[strftime])); then
		_STOPWATCH_DATA[${name}_start]=$EPOCHREALTIME
	else
		_STOPWATCH_DATA[${name}_start]=$(date +%s.%N)
	fi

	_STOPWATCH_DATA[${name}_running]="true"
}

_stamp() {
	local name="$1"
	local start_time="${_STOPWATCH_DATA[${name}_start]}"
	[[ -z "$start_time" ]] && {
		echo "Error: '$name' not started" >&2
		return 1
	}

	zmodload zsh/datetime 2>/dev/null
	local now=${EPOCHREALTIME:-$(date +%s.%N)}

	# Pure Zsh math (no bc!)
	local elapsed=$((now - start_time))
	_format_time "$elapsed" "$name" ""
}

_stop() {
	local name="$1"
	local start_time="${_STOPWATCH_DATA[${name}_start]}"
	[[ -z "$start_time" ]] && {
		echo "Error: '$name' not started" >&2
		return 1
	}
	[[ "${_STOPWATCH_DATA[${name}_running]}" != "true" ]] && return 0

	zmodload zsh/datetime 2>/dev/null
	local now=${EPOCHREALTIME:-$(date +%s.%N)}

	local elapsed=$((now - start_time))
	_STOPWATCH_DATA[${name}_running]="false"

	_format_time "$elapsed" "$name" "⏱️  "
}

# Public API
start() { _is_stopwatch_enabled && _start "$@"; }
stamp() { _is_stopwatch_enabled && _stamp "$@"; }
stop() { _is_stopwatch_enabled && _stop "$@"; }
