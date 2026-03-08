#!/usr/bin/env bash

# usage: mp4-to-webp.sh input.mp4 [fps=30] [height=1080] output.webp

in="$1"
fps="${2:-30}"
height="${3:-1080}"
out="$4"

ffmpeg -i "$in" \
	-vf "fps=$fps,scale=-1:$height:flags=lanczos" \
	-c:v libwebp -lossless 1 -loop 0 -an \
	"$out"

# My Notes: (@AI: dont touch)
# -vf = video filter (the string which defines the output video)
# -codex:video = -c:v
# -an = no audio
