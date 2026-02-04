local wezterm = require("wezterm")
local config = {}

config.color_scheme = "Catppuccin Mocha" -- https://wezterm.org/colorschemes/c/index.html#catppuccin-macchiato
config.font = wezterm.font("CommitMono Nerd Font")

config.window_padding = {
	left = 0,
	-- commented out right padding in hope to restore scrolling functionality
	-- right = 0,
	top = 0,
	bottom = 0,
}

-- comment in when on windows or wsl
-- config.default_prog = { "C:\\Program Files\\Git\\bin\\bash.exe" }

return config
