local wezterm = require("wezterm")
local config = {}

config.color_scheme = "Catppuccin Mocha" -- https://wezterm.org/colorschemes/c/index.html#catppuccin-macchiato
config.font = wezterm.font("CommitMono Nerd Font")

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

return config
