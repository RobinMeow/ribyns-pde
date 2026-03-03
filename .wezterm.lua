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

-- partial update the current config. should be the default if you ask me
local function update(new_overrides, window)
	local overrides = window:get_config_overrides() or {}
	for k, v in pairs(new_overrides) do
		overrides[k] = v
	end
	window:set_config_overrides(overrides)
end

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

local current_brightness = 0.05
local current_opacity = 0.9
local function apply_wallpaper(window, path)
	update({
		window_background_opacity = 1, -- kill transparent
		colors = { background = "black" },
		window_background_image = path,
		window_background_image_hsb = { brightness = current_brightness },
	}, window)
end

local toggle_transparent_bg = function(window, _)
	transparent_bg = not transparent_bg

	if transparent_bg then
		update({
			window_background_opacity = current_opacity,
			window_background_image = "",
			colors = { background = "black" },
			window_background_image_hsb = { brightness = 1 }, -- kill brightness setting for backgorund image, tho it shouldnt matter
		}, window)
	else
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
	current_index = current_index + 1
	if current_index > #wallpapers then
		current_index = 1
	end

	ensure_bg_is_not_transparent(window)
	apply_wallpaper(window, wallpapers[current_index])
end)
wezterm.on("random-wallpaper", function(window, _)
	math.randomseed(os.time())
	current_index = math.random(1, #wallpapers)

	ensure_bg_is_not_transparent(window)
	apply_wallpaper(window, wallpapers[current_index])
end)

config.window_decorations = "RESIZE" -- remove the window title-bar which includes minmizing, fullscreening, and closing
-- maximize window on startup
wezterm.on("gui-startup", function(cmd)
	if mux then
		local window = mux.spawn_window(cmd or {})
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
bind_key("LEADER", "z", act.EmitEvent("reload-wezterm"))
wezterm.on("reload-wezterm", function(_, _)
	wallpapers = load_wallpapers()
	wezterm.log_info("wallpapers reloaded")
end)

bind_key("LEADER", "p", act.ActivateTabRelative(-1)) -- nav to prev tab
bind_key("LEADER", "n", act.ActivateTabRelative(1)) -- nav to next tab

bind_key("LEADER", "x", act.CloseCurrentPane({ confirm = true }))
bind_key("LEADER", "c", act.SpawnTab("CurrentPaneDomain"))

-- navigation
bind_key("LEADER", "h", act.ActivatePaneDirection("Left"))
bind_key("LEADER", "j", act.ActivatePaneDirection("Down"))
bind_key("LEADER", "k", act.ActivatePaneDirection("Up"))
bind_key("LEADER", "l", act.ActivatePaneDirection("Right"))

bind_key("CTRL|SHIFT", "K", act.EmitEvent("increase-light"))
bind_key("CTRL|SHIFT", "J", act.EmitEvent("decrease-light"))

-- idk why i need to use shift+phys: https://wezterm.org/config/keys.html#physical-vs-mapped-key-assignments
-- SHIFT+5 = "
bind_key("LEADER|SHIFT", "phys:5", act.SplitHorizontal({ domain = "CurrentPaneDomain" }))
-- SHIFT+' = "
bind_key("LEADER|SHIFT", "phys:Quote", act.SplitVertical({ domain = "CurrentPaneDomain" }))

-- brightness on the fly
local function enter_change_light_mode()
	return act.ActivateKeyTable({ name = "change_light_kt", one_shot = false })
end
bind_key("LEADER", "b", enter_change_light_mode())

local function clamp(value, min, max)
	return math.max(min, math.min(max, value))
end
local function change_light(delta, window)
	if transparent_bg then
		current_opacity = clamp(current_opacity + (delta * -1), 0, 1)
		update({
			window_background_opacity = current_opacity,
		}, window)
	else
		current_brightness = clamp(current_brightness + delta, 0, 1)
		update({
			window_background_image_hsb = { brightness = current_brightness },
		}, window)
	end
end

-- resizing
-- Each arrow triggers resize mode when pressed after prefix
local function enter_resize_mode()
	return act.ActivateKeyTable({ name = "resize_pane", one_shot = false })
end
bind_key("LEADER", "LeftArrow", enter_resize_mode())
bind_key("LEADER", "DownArrow", enter_resize_mode())
bind_key("LEADER", "UpArrow", enter_resize_mode())
bind_key("LEADER", "RightArrow", enter_resize_mode())

local brightness_delta = 0.005
wezterm.on("increase-light", function(window, _)
	change_light(brightness_delta, window)
end)
wezterm.on("decrease-light", function(window, _)
	change_light(brightness_delta * -1, window)
end)
config.key_tables = {
	resize_pane = {
		{ key = "LeftArrow", action = act.AdjustPaneSize({ "Left", 2 }) },
		{ key = "DownArrow", action = act.AdjustPaneSize({ "Down", 2 }) },
		{ key = "UpArrow", action = act.AdjustPaneSize({ "Up", 2 }) },
		{ key = "RightArrow", action = act.AdjustPaneSize({ "Right", 2 }) },
		{ key = "Escape", action = "PopKeyTable" }, -- exit resizing mode
	},
	-- https://github.com/wezterm/wezterm/issues/5318 wont-fix
	-- change_light_kt = {
	-- 	-- { key = "k", action = act.EmitEvent("increase-light") },
	-- 	-- { key = "j", action = act.EmitEvent("decrease-light") },
	-- 	{ key = "Escape", action = "PopKeyTable" }, -- exit change_light_kt mode
	-- },
}

-- leader + number to switch tabs
for i = 1, 9 do
	bind_key("LEADER", tostring(i), act.ActivateTab(i - 1))
end

-- show while leader key is active
wezterm.on("update-right-status", function(window, _)
	local leader_active = window:leader_is_active() and (" " .. utf8.char(0x1F9D9, 0x200D, 0x2642)) or ""
	local active_key_table = window:active_key_table()

	local status = ""
	if active_key_table == "resize_pane" then
		status = "RESIZING - esc to exit "
	elseif active_key_table == "change_light_kt" then
		status = "BRIGHTNESS - esc to exit "
	end

	window:set_right_status(wezterm.format({
		{ Text = status },
		{ Background = { Color = "#b7bdf8" } }, -- some purple similar to catppuccin
		-- https://www.utf8icons.com/character/129497/mage ( and or is conditional assignment in lua. like leader_is_active ? mage : "")
		{ Text = leader_active },
	}))
end)

return config
