local wezterm = require("wezterm")
local mux = wezterm.mux
local act = wezterm.action
local config = {}

config.color_scheme = "Catppuccin Mocha" -- https://wezterm.org/colorschemes/c/index.html#catppuccin-macchiato
config.font = wezterm.font("CommitMono Nerd Font")

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false

-- Windows/Wsl/Linux
-- ensure wezterm starts in wsl and cwd is correctly carried over to new panes/tabs
local running_on_windows = package.config:sub(1, 1) == "\\"
if running_on_windows then
	-- https://wezterm.org/config/lua/config/default_domain.html
	-- https://github.com/wezterm/wezterm/issues/2090
	local wsl_domains = wezterm.default_wsl_domains()

	for _, dom in ipairs(wsl_domains) do
		dom.default_cwd = "~"
	end

	config.wsl_domains = wsl_domains
	config.default_domain = "WSL:archlinux"
end

-- background
local transparent_bg = true
local current_index = 1
local function load_wallpapers()
	local sep = package.config:sub(1, 1)
	local wallpapers_dir = wezterm.config_dir .. sep .. ".config" .. sep .. "wezterm" .. sep .. "wallpapers"
	local result = wezterm.glob(wallpapers_dir .. sep .. "*")
	return result
end
local wallpapers = load_wallpapers()

local function apply_wallpaper(window, path)
	window:set_config_overrides({
		window_background_opacity = 1,
		colors = { background = "black" },
		window_background_image = path,
		window_background_image_hsb = { brightness = 0.05 },
	})
end

local toggle_transparent_bg = function(window, _)
	transparent_bg = not transparent_bg

	if transparent_bg then
		window:set_config_overrides({
			window_background_opacity = 0.9,
			window_background_image = nil,
			colors = { background = "black" },
		})
	else
		local wallpapers = wallpapers
		apply_wallpaper(window, wallpapers[current_index])
	end
end

local function ensure_bg_is_not_transparent(window)
	if transparent_bg then
		toggle_transparent_bg(window)
	end
end

wezterm.on("toggle-transparent", toggle_transparent_bg)
wezterm.on("cycle-wallpaper", function(window, _)
	local wallpapers = wallpapers
	current_index = current_index + 1
	if current_index > #wallpapers then
		current_index = 1
	end

	ensure_bg_is_not_transparent(window)
	apply_wallpaper(window, wallpapers[current_index])
end)
wezterm.on("random-wallpaper", function(window, _)
	local wallpapers = wallpapers
	math.randomseed(os.time())
	current_index = math.random(1, #wallpapers)

	ensure_bg_is_not_transparent(window)
	apply_wallpaper(window, wallpapers[current_index])
end)

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

-- background keymaps
bind_key("LEADER", "t", act.EmitEvent("toggle-transparent"))
bind_key("LEADER", "i", act.EmitEvent("cycle-wallpaper"))
bind_key("LEADER", "r", act.EmitEvent("random-wallpaper"))

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
