#!/usr/bin/env bash
set -euo pipefail

source "$RIBYNS_ENV/scripts/utils.sh"

usage() {
	cat <<EOF
Usage: $(basename "$0") --input <path>

Packages files into 7z archives with max compression, 
split into 49MB volumes.

Options:
  -i, --input <path>     Directory of files or path to a single file
  -h, --help         Show this help message and exit
EOF
	exit 0
}

INPUT_DIR=""

while [[ "$#" -gt 0 ]]; do
	case $1 in
	-i | --input)
		INPUT_DIR="$2"
		shift 2
		;;
	-h | --help) usage ;;
	*)
		error "Unknown parameter: $1"
		usage
		;;
	esac
done

[[ -z "${INPUT_DIR}" ]] && {
	error "--input is required"
	usage
}

OUTPUT_DIR="$RIBYNS_ENV/images/zip"

if [ -d "$INPUT_DIR" ]; then
	FILES=("$INPUT_DIR"/*)
else
	FILES=("$INPUT_DIR")
fi

mkdir -p "$OUTPUT_DIR"

for file in "${FILES[@]}"; do
	# If the glob didn't expand, it means no files were found
	if [[ ! -e "$file" ]]; then
		error "No files found in $INPUT_DIR"
		exit 1
	fi

	# Throw if a subdirectory is found
	if [[ -d "$file" ]]; then
		error "Found subdirectory: $file"
		error "This script only supports files. Please check your input."
		exit 1
	fi

	filename=$(basename "$file")
	info "Packaging: $filename"

	# "${OUTPUT_BASE}/${filename}.7z" : Output path

	7z -mx=9 -v49m a "${OUTPUT_DIR}/${filename}.7z" "$file"
	info "Created archive for $filename"
done

success "All files packaged in $OUTPUT_DIR"
