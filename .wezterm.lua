local wezterm = require("wezterm")
local mux = wezterm.mux
local act = wezterm.action
local config = {}

config.color_scheme = "Catppuccin Mocha" -- https://wezterm.org/colorschemes/c/index.html#catppuccin-macchiato
config.font = wezterm.font("CommitMono Nerd Font")

-- partial update the current config. should be the default if you ask me
local function update(new_overrides, window)
	local overrides = window:get_config_overrides() or {}
	for k, v in pairs(new_overrides) do
		overrides[k] = v
	end
	window:set_config_overrides(overrides)
end

local function get_default_font_size(screen)
	local width = screen.width
	-- 1440p (2560px), 1080p (1920px), Laptop (<1920px)
	if width >= 2560 then
		return 14
	elseif width >= 1920 then
		return 14
	else
		return 11
	end
	-- what a waste of time. i thought i would choose different font sizes based on resolution. recheck on work day
end
-- sets the font size based on the active-screen's resolution
local function auto_set_font_size(window)
	local all_screens = wezterm.gui.screens()
	local active_screen = all_screens["active"]
	local default_font_size = get_default_font_size(active_screen)
	wezterm.log_info(
		"Init FontSize: "
			.. "from default "
			.. tostring(config.font_size)
			.. " to "
			.. tostring(default_font_size)
			.. "; Resolution: "
			.. tostring(active_screen.width)
			.. "x"
			.. tostring(active_screen.height)
	)
	window:set_config_overrides({ font_size = default_font_size })
end

local fk_microsoft = false
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
local bg_mode = "wallpapers" -- "wallpapers" | "motions"
local transparent_bg = false
local current_wallpaper_idx = 1
local function load_backgrounds()
	local sep = package.config:sub(1, 1)
	local dir = wezterm.config_dir .. sep .. ".config" .. sep .. "wezterm" .. sep .. bg_mode
	return wezterm.glob(dir .. sep .. "*")
end
local wallpapers = load_backgrounds()
local current_brightness = 0.025
local current_opacity = 0.9

-- inital background
config.window_background_opacity = 1 -- kill transparent
config.colors = { background = "black" }
local inital_bg = wallpapers[math.random(#wallpapers)]
wezterm.log_info("Initial Bg: " .. inital_bg)
config.window_background_image = inital_bg
config.window_background_image_hsb = { brightness = current_brightness }

local function apply_background(window, path)
	wezterm.log_info("apply background " .. bg_mode .. ": " .. path)
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
		apply_background(window, wallpapers[current_wallpaper_idx])
	end
end

local function ensure_bg_is_not_transparent(window)
	if transparent_bg then
		toggle_transparent_bg(window)
	end
end

wezterm.on("toggle-transparent", toggle_transparent_bg)
wezterm.on("iterate-wallpaper", function(window, _)
	current_wallpaper_idx = current_wallpaper_idx + 1
	if current_wallpaper_idx > #wallpapers then
		current_wallpaper_idx = 1
	end

	ensure_bg_is_not_transparent(window)
	apply_background(window, wallpapers[current_wallpaper_idx])
end)

wezterm.on("cycle-bg-mode", function(window, _)
	bg_mode = (bg_mode == "wallpapers") and "motions" or "wallpapers"
	wallpapers = load_backgrounds()
	current_wallpaper_idx = math.random(#wallpapers)
	ensure_bg_is_not_transparent(window)
	apply_background(window, wallpapers[current_wallpaper_idx])
	wezterm.log_info("Switched to mode: " .. bg_mode)
end)

local function load_random_wallpaper(window, _)
	math.randomseed(os.time())
	current_wallpaper_idx = math.random(1, #wallpapers)

	ensure_bg_is_not_transparent(window)
	apply_background(window, wallpapers[current_wallpaper_idx])
end
wezterm.on("random-wallpaper", load_random_wallpaper)

config.window_decorations = "INTEGRATED_BUTTONS" -- remove the window title-bar which includes minmizing, fullscreening, and closing

-- maximize window on startup
wezterm.on("gui-startup", function(cmd)
	if mux then
		local _, _, window = mux.spawn_window(cmd or {})
		window:gui_window():maximize()
		xpcall(function()
			auto_set_font_size(window:gui_window())
		end, function(err)
			wezterm.log_info("err: " .. tostring(err))
		end)
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
bind_key("LEADER", "i", act.EmitEvent("iterate-wallpaper"))
bind_key("LEADER", "r", act.EmitEvent("random-wallpaper"))
bind_key("LEADER", "v", act.EmitEvent("cycle-bg-mode"))
bind_key("LEADER", "z", act.EmitEvent("reload-wezterm"))
wezterm.on("reload-wezterm", function(_, _)
	wallpapers = load_backgrounds()
	wezterm.log_info(bg_mode .. " reloaded")
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

local light_delta = 0.005
wezterm.on("increase-light", function(window, _)
	change_light(light_delta, window)
end)
wezterm.on("decrease-light", function(window, _)
	change_light(light_delta * -1, window)
end)
config.key_tables = {
	resize_pane = {
		{ key = "LeftArrow", action = act.AdjustPaneSize({ "Left", 2 }) },
		{ key = "DownArrow", action = act.AdjustPaneSize({ "Down", 2 }) },
		{ key = "UpArrow", action = act.AdjustPaneSize({ "Up", 2 }) },
		{ key = "RightArrow", action = act.AdjustPaneSize({ "Right", 2 }) },
		{ key = "Escape", action = "PopKeyTable" }, -- exit resizing mode
	},
	-- do not try again to use key_tables in combination with set_config_overrides.
	-- https://github.com/wezterm/wezterm/issues/5318 wont-fix since 2024
}

-- leader + number to switch tabs
for i = 1, 9 do
	bind_key("LEADER", tostring(i), act.ActivateTab(i - 1))
end

-- show while leader key is active
wezterm.on("update-right-status", function(window, _)
	---@diagnostic disable-next-line: undefined-global
	local leader_active = window:leader_is_active() and (" " .. utf8.char(0x1F9D9, 0x200D, 0x2642)) or ""
	local active_key_table = window:active_key_table()

	local status = ""
	if active_key_table == "resize_pane" then
		status = "RESIZING - esc to exit "
	end

	window:set_right_status(wezterm.format({
		{ Text = status },
		{ Background = { Color = "#b7bdf8" } }, -- some purple similar to catppuccin
		-- https://www.utf8icons.com/character/129497/mage ( and or is conditional assignment in lua. like leader_is_active ? mage : "")
		{ Text = leader_active },
	}))
end)

local toggle_padding = function(window, _)
	fk_microsoft = not fk_microsoft

	if fk_microsoft then
		update({
			window_padding = { left = 4, right = 0, top = 5, bottom = 5 },
		}, window)
	else
		update({ window_padding = { left = 0, right = 0, top = 0, bottom = 0 } }, window)
	end
end

wezterm.on("toggle-padding", toggle_padding)

bind_key("LEADER", "m", act.EmitEvent("toggle-padding"))

return config
