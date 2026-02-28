PDE=$HOME/ribyns-pde
cp "$HOME/.config/nvim/init.lua" "$PDE/.config/nvim/init.lua"
cp "$HOME/.zshrc" "$PDE/.zshrc"

# TODO: should check for clean git state and fail if not clean
#cp "/mnt/c/Users/Ribyn/.wezterm.lua" "$PDE/.wezterm.lua"

git diff
git checkout .
