local m = {}

function m.setup()
  local key = require("key")
  -- Example binds https://wiki.hypr.land/Configuring/Basics/Binds/
  key.bind("SUPER + T", hl.dsp.exec_cmd("kitty"), { desc = "open kitty terminal" })

  ---@diagnostic disable-next-line: unused-local
  local closeWindowBind = key.bind("SUPER + SHIFT + Q", hl.dsp.window.close(), { desc = "close window" })
  -- closeWindowBind:set_enabled(false)

  key.bind(
    -- right homerow fingers + [b]ye
    "SUPER + CTRL + B",
    hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"),
    { desc = "shutdown hyprland (cli cmd `hyprbye`)" }
  )

  key.bind("SUPER + Y", hl.dsp.exec_cmd("kitty -e yazi"), { desc = "open yazi" })

  key.bind("SUPER + SHIFT + I", hl.dsp.exec_cmd("kaomoji-picker"), { desc = "open kaomoji picker (emoticons)" })

  -- https://wiki.hypr.land/Configuring/Basics/Dispatchers/#fullscreenstate
  -- internal is a reference to the state maintained by Hyprland.
  -- client is a reference to the state that the application receives.
  key.bind(
    "SUPER + F",
    -- toggle fullscreen without toggleing the fullscreen of the inner app (streaming video)
    hl.dsp.window.fullscreen_state({ internal = 2, client = -1, mode = "fullscreen", action = "toggle" }),
    { desc = "toggle fullscreen" }
  )
  key.bind(
    "SUPER + SHIFT + F",
    -- toggle fullscreen within the inner app (didnt work as planned,
    -- but I can toggle this on, and than use vimium to click fullscreen to get my desired effect)
    hl.dsp.window.fullscreen_state({ internal = -1, client = 2, mode = "fullscreen", action = "toggle" }),
    { desc = "toggle fullscreen within inner app (e.g. in PWA)" }
  )

  -- NOTE: alternatives are hyprlauncher (just-works), anyrun (for powerusers: as in, run anything), fuzzel (for speed)
  key.bind(
    "SUPER + R",
    hl.dsp.exec_cmd('rofi -show drun -show-icons -icon-theme "Adwaita"'),
    { desc = "open rofi - desktop file launcher" }
  )
  key.bind(
    "SUPER + SHIFT + R",
    hl.dsp.exec_cmd('rofi -show window -show-icons -icon-theme "Adwaita"'),
    { desc = "open rofi - window switcher" }
  )

  -- works only for dwindle according to the docs
  -- but also works for the hy3 plugin
  key.bind("SUPER + V", hl.dsp.layout("togglesplit"), { locked = true, desc = "toggle split" })

  -- Move focus with SUPER + vim keys
  key.bind("SUPER + H", hl.dsp.focus({ direction = "left" }), { desc = "focus window: to the left" })
  key.bind("SUPER + J", hl.dsp.focus({ direction = "down" }), { desc = "focus window: downwards" })
  key.bind("SUPER + K", hl.dsp.focus({ direction = "up" }), { desc = "focus window: upwards" })
  key.bind("SUPER + L", hl.dsp.focus({ direction = "right" }), { desc = "focus window: to the right" })

  if require("hy3").enabled then
    -- mainly, hy3 allows me to manage windows in nvim/i3 style
    -- using the movement, against the screenedge to give a window prio
    -- in size. which is node-tree based and not supported by hyprland's
    -- default layouts
    local hy3 = hl.plugin.hy3
    key.bind("SUPER + SHIFT + H", hy3.move_window("l"), { desc = "move window to the left" })
    key.bind("SUPER + SHIFT + J", hy3.move_window("d"), { desc = "move window downwards" })
    key.bind("SUPER + SHIFT + K", hy3.move_window("u"), { desc = "move window upwards" })
    key.bind("SUPER + SHIFT + L", hy3.move_window("r"), { desc = "move window to the right" })
  else
    key.bind("SUPER + SHIFT + H", hl.dsp.window.move({ direction = "l" }), { desc = "move window to the left" })
    key.bind("SUPER + SHIFT + J", hl.dsp.window.move({ direction = "d" }), { desc = "move window downwards" })
    key.bind("SUPER + SHIFT + K", hl.dsp.window.move({ direction = "u" }), { desc = "move window upwards" })
    key.bind("SUPER + SHIFT + L", hl.dsp.window.move({ direction = "r" }), { desc = "move window to the right" })
  end

  for i = 1, 10 do
    local digit = i % 10 -- 10 maps to key 0 (which is after 9 on most keyboards)
    hl.bind(
      "SUPER + " .. digit,
      hl.dsp.focus({ workspace = tostring(digit) }),
      { desc = "switch workspace to " .. digit }
    )
    hl.bind(
      "SUPER + SHIFT + " .. digit,
      hl.dsp.window.move({ workspace = tostring(digit) }),
      { desc = "move window to workspace " .. digit }
    )
  end
  local help = require("help")
  help.add("SUPER + [0-9]", "switch to workspace [0-9]")
  help.add("SUPER + SHFIT + [0-9]", "move window to workspace [0-9]")

  key.bind("SUPER + ALT + L", function()
    -- relative +1
    hl.dispatch(hl.dsp.workspace.move({ monitor = "+1" }))
  end, { desc = "move the workspace to the next monitor" })
  key.bind("SUPER + ALT + H", function()
    -- relative -1
    hl.dispatch(hl.dsp.workspace.move({ monitor = "-1" }))
  end, { desc = "move the workspace to the prev monitor" })

  -- special workspace (aka scratchpad)
  key.bind("SUPER + S", hl.dsp.workspace.toggle_special("magic"), { desc = "toggle special workspace" })
	-- stylua: ignore
  key.bind( "SUPER + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }), { desc = "move window to special workspace" })

  key.bind("SUPER + E", hl.dsp.workspace.toggle_special("email"), { desc = "toggle email workspace" })
	-- stylua: ignore
  key.bind( "SUPER + SHIFT + E", hl.dsp.window.move({ workspace = "special:email" }), { desc = "move window to email workspace" })

  key.bind("SUPER + TAB", hl.dsp.focus({ workspace = "e+1" }), { desc = "focus next workspace" })
  key.bind("SUPER + SHIFT + TAB", hl.dsp.focus({ workspace = "e-1" }), { desc = "focus prev workspace" })

  -- NOTE: example for mouse keybind.
  -- Move windows with SUPER + LMB and dragging
  -- local LMB = "mouse:272" -- left mouse button
  -- key.bind("SUPER + " .. LMB, hl.dsp.window.drag(), { mouse = true })
  -- resize windows with SUPER + RMB and dragging
  -- local RMB = "mouse:273" -- right mouse button
  -- key.bind("SUPER + " .. RMB, hl.dsp.window.resize(), { mouse = true })

  -- TODO: use submap with R resize. more consitent with all the other multiplexers
  local step = 100
  key.bind(
    "SUPER + left",
    hl.dsp.window.resize({ x = -step, y = 0, relative = true }),
    { desc = "relative resizing: left" }
  )
  key.bind(
    "SUPER + down",
    hl.dsp.window.resize({ x = 0, y = step, relative = true }),
    { desc = "relative resizing: down" }
  )
  key.bind(
    "SUPER + up",
    hl.dsp.window.resize({ x = 0, y = -step, relative = true }),
    { desc = "relative resizing: up" }
  )
  key.bind(
    "SUPER + right",
    hl.dsp.window.resize({ x = step, y = 0, relative = true }),
    { desc = "relative resizing: right" }
  )

  key.bind("SUPER + P", require("potato_mode").toggle, { locked = true, desc = "toggle potato mode" })
  key.bind("SUPER + G", require("gaps").toggle, { locked = true, desc = "toggle gaps (padding/margins)" })

  key.bind(
    "Print",
    hl.dsp.exec_cmd('grim -g "$(slurp)" - | swappy -f -'),
    { desc = "screenshot with rectangular selection" }
  )

  key.bind("SUPER + PAUSE", hl.dsp.exec_cmd("wl-freeze -a"), { desc = "toggle wl-freeze the currently active window" })
  key.bind(
    "SUPER + B",
    hl.dsp.exec_cmd("wl-freeze --name mpvpaper"),
    { desc = "toggle wl-freeze on mpvpaper (background video)" }
  )

  local function exec_cmd(cmd)
    hl.dispatch(hl.dsp.exec_cmd(cmd))
  end

  key.bind("SUPER + O", function()
    local handle = io.popen("pgrep --exact waybar")
    if handle then
      local waybar_pid = handle:read("*a")
      handle:close()
      local waybar_was_running = waybar_pid ~= nil and waybar_pid ~= ""
      if waybar_was_running then
        exec_cmd("pkill --exact waybar; hyprlock --grace 10; waybar & disown")
      else
        exec_cmd("hyprlock --grace 10;")
      end
    else
      exec_cmd("pkill --exact waybar; hyprlock --grace 10")
    end
  end, { desc = "lock screen" })

  key.bind("SUPER + W", hl.dsp.exec_cmd("pkill --exact waybar || waybar"), { desc = "stop/start waybar" })

  local step = 0.05

  key.bind("SUPER + SHIFT + up", function()
    local brightness = hl.get_config("decoration.blur.brightness")
    local new_brightness = math.min(1.0, brightness + step)
    hl.config({ decoration = { blur = { brightness = new_brightness } } })
  end, { repeating = true, desc = "Increase Brightness" })

  key.bind("SUPER + SHIFT + down", function()
    local brightness = hl.get_config("decoration.blur.brightness")
    local new_brightness = math.max(0.0, brightness - step)
    hl.config({ decoration = { blur = { brightness = new_brightness } } })
  end, { repeating = true, desc = "Decrease Brightness" })

  -- WARN: hyprland has no disptcher for focusing layers
  -- so I have to move the mouse before I can use keybinds
  -- using toggle fucntionality instead to work around it
  key.bind("SUPER + CTRL + S", function()
    local handle = io.popen("pgrep --exact wayscriber")
    if handle then
      local wayscriber_pid = handle:read("*a")
      handle:close()
      local wayscriber_is_running = wayscriber_pid ~= nil and wayscriber_pid ~= ""
      if wayscriber_is_running then
        exec_cmd("pkill --exact wayscriber")
      else
        exec_cmd("wayscriber --active")
      end
    else
      hl.notification.create({ text = "Failed to pgrep?", timeout = 5000 })
    end
  end, { desc = "start wayscriber" })

  -- dunst
  key.bind("SUPER + C", hl.dsp.exec_cmd("dunstctl close"), { desc = "close notification" })
  key.bind("SUPER + SHIFT + C", hl.dsp.exec_cmd("dunstctl close-all"), { desc = "close all notifications" })
  key.bind("SUPER + D", hl.dsp.exec_cmd("dunstctl history-pop"), { desc = "display last notification again" })

  -- multimedia keys for volume and LCD brightness (usually on laptops for fn keys)
  -- NOTE: according to AI, locked is for allow in lock-screen and repeating for hold to spam
  key.bind(
    "XF86AudioRaiseVolume",
    hl.dsp.exec_cmd("wob_volume up"),
    { locked = true, repeating = true, desc = "volume up +5%" }
  )
  key.bind(
    "XF86AudioLowerVolume",
    hl.dsp.exec_cmd("wob_volume down"),
    { locked = true, repeating = true, desc = "volume down -5%" }
  )
  key.bind(
    "XF86AudioMute",
    hl.dsp.exec_cmd("wob_volume mute"),
    { locked = true, repeating = true, desc = "mute volume" }
  )
  key.bind(
    "XF86AudioMicMute",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
    { locked = true, repeating = true, desc = "mute microphone" }
  )
  key.bind(
    "XF86MonBrightnessUp",
    hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),
    { locked = true, repeating = true, desc = "monitor brightness up +5%" }
  )
  key.bind(
    "XF86MonBrightnessDown",
    hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),
    { locked = true, repeating = true, desc = "monitor brightness up -5%" }
  )
  key.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true, desc = "media audio play" })
  key.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true, desc = "media audio pause" })
  key.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true, desc = "media audio next" })
  key.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true, desc = "media audio prev" })
end

return m
