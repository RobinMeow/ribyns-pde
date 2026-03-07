# usage: mp4-to-webp.sh input-file.mp4 <fps:30> <height:1080> output-file.webp
ffmpeg -i $1 -vf "fps=$2,scale=width=-1:height=$3:flags=lanczos" -c:v libwebp -lossless 1 -loop 0 -an $4

# -vf = video filter (the string which defines the output video)
# -codex:video = -c:v
# -an = no audio
