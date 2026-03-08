#!/usr/bin/env bash

# Default values
fps=30
height=1440
quality=80

# Parse named arguments
while [[ "$#" -gt 0 ]]; do
	case $1 in
	--input)
		INPUT_DIR="$2"
		shift
		;;
	--fps)
		fps="$2"
		shift
		;;
	--height)
		height="$2"
		shift
		;;
	--quality)
		quality="$2"
		shift
		;;
	*)
		echo "Unknown parameter: $1"
		exit 1
		;;
	esac
	shift
done

# check if INPUT_DIR is set and not empty
[[ -z "${INPUT_DIR}" ]] && {
	echo "Error: --input <input-dir> is required"
	exit 1
}

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PDE="$SCRIPT_DIR/.." # the git repo this script is in
OUTPUT_DIR="$PDE/tmp/$(basename "$INPUT_DIR")"

fps="${2:-30}"
height="${3:-1440}"
quality="${4:-80}"

mkdir -p "$OUTPUT_DIR"

for file in "$INPUT_DIR"/*.mp4; do
	name=$(basename "$file" .mp4) # strip .mp4 from basename

	ffmpeg -i "$file" \
		-vf "fps=$fps,scale=-1:$height:flags=lanczos" \
		-c:v libwebp -q:v "$quality" -loop 0 -an \
		"$OUTPUT_DIR/$name.webp"
done
