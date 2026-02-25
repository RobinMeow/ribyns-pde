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
end

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.window_background_image = wezterm.config_dir .. "\\.wezterm_background.jpg"
config.window_background_image_hsb = { brightness = 0.05 }

config.window_decorations = "RESIZE" -- remove the window title-bar which includes minmizing, fullscreening, and closing
-- maximize window on startup
wezterm.on("gui-startup", function(cmd)
	if mux then
		local tab, pane, window = mux.spawn_window(cmd or {})
		window:gui_window():maximize()
	end
end)

-- tmux
config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 2000 }

local function bind_key(mods, key, action)
	config.keys = config.keys or {}
	table.insert(config.keys, { mods = mods, key = key, action = action })
end

bind_key("LEADER", "p", act.ActivateTabRelative(-1)) -- nav to prev tab
bind_key("LEADER", "n", act.ActivateTabRelative(1)) -- nav to next tab

bind_key("LEADER", "x", act.CloseCurrentPane({ confirm = true }))
bind_key("LEADER", "c", act.SpawnTab("CurrentPaneDomain"))

-- navigation
bind_key("LEADER", "h", act.ActivatePaneDirection("Left"))
bind_key("LEADER", "j", act.ActivatePaneDirection("Down"))
bind_key("LEADER", "k", act.ActivatePaneDirection("Up"))
bind_key("LEADER", "l", act.ActivatePaneDirection("Right"))

-- idk why i need to use shift+phys: https://wezterm.org/config/keys.html#physical-vs-mapped-key-assignments
-- SHIFT+5 = "
bind_key("LEADER|SHIFT", "phys:5", act.SplitHorizontal({ domain = "CurrentPaneDomain" }))
-- SHIFT+' = "
bind_key("LEADER|SHIFT", "phys:Quote", act.SplitVertical({ domain = "CurrentPaneDomain" }))

-- resizing
-- Each arrow triggers resize mode when pressed after prefix
local function enter_resize_mode()
	return act.ActivateKeyTable({ name = "resize_pane", one_shot = false })
end
bind_key("LEADER", "LeftArrow", enter_resize_mode())
bind_key("LEADER", "DownArrow", enter_resize_mode())
bind_key("LEADER", "UpArrow", enter_resize_mode())
bind_key("LEADER", "RightArrow", enter_resize_mode())
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
	bind_key("LEADER", tostring(i), act.ActivateTab(i - 1))
end

-- show while leader key is active
wezterm.on("update-right-status", function(window, _)
	local leader_active = window:leader_is_active() and (" " .. utf8.char(0x1F9D9, 0x200D, 0x2642)) or ""
	local resize_mode_active = window:active_key_table() == "resize_pane" and "RESIZING - press esc to exit" or ""
	window:set_right_status(wezterm.format({
		{ Text = resize_mode_active },
		{ Background = { Color = "#b7bdf8" } }, -- some purple similar to catppuccin
		-- https://www.utf8icons.com/character/129497/mage ( and or is conditional assignment in lua. like leader_is_active ? mage : "")
		{ Text = leader_active },
	}))
end)

return config
