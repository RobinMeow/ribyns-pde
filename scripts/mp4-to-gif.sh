# usage: input-file.mp4 <fps:30> <height:1080> output-file.gif

ffmpeg -i "$1" -vf "fps=$2,scale=-1:$3:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" -loop 0 "$4"
