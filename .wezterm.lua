local wezterm = require("wezterm")
local mux = wezterm.mux
local act = wezterm.action
local config = {}

config.color_scheme = "Catppuccin Mocha" -- https://wezterm.org/colorschemes/c/index.html#catppuccin-macchiato
config.font = wezterm.font("CommitMono Nerd Font")

-- WSL
-- ensure wezterm starts in wsl and cwd is correctly carried over to new panes/tabs
-- https://wezterm.org/config/lua/config/default_domain.html
-- https://github.com/wezterm/wezterm/issues/2090
-- set to false for non-wsl environments
if true then
	local wsl_domains = wezterm.default_wsl_domains()

	for _, dom in ipairs(wsl_domains) do
		dom.default_cwd = "~"
	end

	config.wsl_domains = wsl_domains
	config.default_domain = "WSL:archlinux"
	config.default_prog = { "wsl.exe" }
end

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false

-- TODO: maximised window
-- wezterm.on("gui-startup", function(cmd)
-- 	local window = mux.spawn_window(cmd or {})
-- 	window:maximize()
-- end)

--config.window_decorations = "RESIZE" -- remove the window title-bar which includes minmizing, fullscreening, and closing

-- tmux
config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 2500 }

local function enter_resize_mode()
	return act.ActivateKeyTable({ name = "resize_pane", one_shot = false })
end

config.keys = {
	{ mods = "LEADER", key = "c", action = act.SpawnTab("CurrentPaneDomain") },
	{ mods = "LEADER", key = "x", action = act.CloseCurrentPane({ confirm = true }) },
	{ mods = "LEADER", key = "p", action = act.ActivateTabRelative(-1) }, -- nav to prev tab
	{ mods = "LEADER", key = "n", action = act.ActivateTabRelative(1) }, -- nav to next tab
	-- idk why i need to use shift+phys: https://wezterm.org/config/keys.html#physical-vs-mapped-key-assignments
	-- { mods = "LEADER", key = '"', action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	-- { mods = "LEADER", key = "%", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{
		mods = "LEADER|SHIFT",
		key = "phys:5", -- SHIFT+5 = "
		action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		mods = "LEADER|SHIFT",
		key = "phys:Quote", -- SHIFT+' = "
		action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	-- navigation
	{ mods = "LEADER", key = "h", action = act.ActivatePaneDirection("Left") },
	{ mods = "LEADER", key = "j", action = act.ActivatePaneDirection("Down") },
	{ mods = "LEADER", key = "k", action = act.ActivatePaneDirection("Up") },
	{ mods = "LEADER", key = "l", action = act.ActivatePaneDirection("Right") },
	-- resizing
	-- Each arrow triggers resize mode when pressed after prefix
	{ key = "LeftArrow", mods = "LEADER", action = enter_resize_mode() },
	{ key = "RightArrow", mods = "LEADER", action = enter_resize_mode() },
	{ key = "UpArrow", mods = "LEADER", action = enter_resize_mode() },
	{ key = "DownArrow", mods = "LEADER", action = enter_resize_mode() },
}

-- allow resizing by pressing the arrow keys repeatedly
config.key_tables = {
	resize_pane = {
		{ key = "LeftArrow", action = act.AdjustPaneSize({ "Left", 2 }) },
		{ key = "DownArrow", action = act.AdjustPaneSize({ "Down", 2 }) },
		{ key = "UpArrow", action = act.AdjustPaneSize({ "Up", 2 }) },
		{ key = "RightArrow", action = act.AdjustPaneSize({ "Right", 2 }) },
		{ key = "Escape", action = "PopKeyTable" }, -- exit resizing mode
	},
}

-- leader + number to switch tabs
for i = 1, 9 do
	table.insert(config.keys, { key = tostring(i), mods = "LEADER", action = act.ActivateTab(i - 1) })
end

return config

