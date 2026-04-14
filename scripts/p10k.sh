target="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

if [ ! -d "$target" ]; then
	url="https://github.com/romkatv/powerlevel10k.git"
	git clone --depth=1 $url $target
	echo "Cloned $url"
else
	echo "Skipped clone (already exists): $target"
fi

cp "$HOME/ribyns-pde/.p10k.zsh" "$HOME/.p10k.zsh"
