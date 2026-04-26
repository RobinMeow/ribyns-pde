# available mirrors: https://archlinux.org/download/

if [[ -d "$HOME/Downloads" ]]; then
	mkdir "$HOME/Downloads"
fi

MIRROR=${MIRROR:-23m.com}

curl -o "$HOME/Downloads/archlinux-x86_64.iso" "https://mirror.$MIRROR/archlinux/iso/latest/archlinux-x86_64.iso"
