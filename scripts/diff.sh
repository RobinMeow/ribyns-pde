PDE=$HOME/ribyns-pde
cp "$HOME/.config/nvim/init.lua" "$PDE/.config/nvim/init.lua"
cp "$HOME/.zshrc" "$PDE/.zshrc"

#cp "/mnt/c/Users/Ribyn/.wezterm.lua" "$PDE/.wezterm.lua"

git diff
git checkout .

