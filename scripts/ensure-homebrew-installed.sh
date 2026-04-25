if [[ -d "/home/linuxbrew/" ]]; then
	echo "skipping brew installed (already installed)"
else
	NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
