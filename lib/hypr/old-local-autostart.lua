-- https://wiki.hypr.land/Configuring/Basics/Autostart/
-- https://wiki.hypr.land/faq/#how-do-i-autostart-my-favorite-apps
local m = {}
m.enabled = false

-- get desc: using `hyprctl devices` (which is shorthand for `hyprctl devices all`)
local front_monitor = "desc:Asus MODEL1 0x00000001"
local left_monitor = "desc:BenQ MODEL2 0x00000002"

-- workspace rules belong into monitors
hl.workspace_rule({ workspace = "1", persistent = true, monitor = front_monitor })
hl.workspace_rule({ workspace = "2", persistent = true, monitor = left_monitor })
hl.workspace_rule({ workspace = "3", persistent = true, monitor = front_monitor })

-- prevent them from stealing focus on startup
hl.window_rule({ match = { class = "discord" }, no_initial_focus = true })
hl.window_rule({ match = { class = "google-chrome" }, no_initial_focus = true })

local chrome_count = 0
local discord_count = 0
local listener
local function move_to_workspace(ws, window)
  hl.dispatch(hl.dsp.window.move({
    workspace = ws,
    follow = false,
    silent = true,
    window = window,
  }))
end
listener = hl.on("window.open", function(window)
  if window.class == "google-chrome" then
    chrome_count = chrome_count + 1
    if chrome_count == 1 then
      move_to_workspace("1", window)
    else
      move_to_workspace("3", window)
    end
  elseif window.class == "discord" then
    discord_count = discord_count + 1
    move_to_workspace("2", window)
  end

  local all_windows_are_opened = chrome_count == 2 and discord_count == 2
  if all_windows_are_opened then
    hl.dispatch(hl.dsp.focus({ window = "class:kitty_main" }))
    listener:remove()
    return
  end
end)

local function autostart()
  -- Daemons
  hl.exec_cmd("mpd") -- uses daemon by default otherwise --no-daemon or --systemd
  hl.exec_cmd("wob_volume listen")
  hl.exec_cmd("hyprpaper") -- uses daemon by default otherwise --no-daemon or --systemd
  -- use mpvpaper default if env RIBYN_HYPR_MPVPAPER_RESOLUTION is locally set on the machine
  -- not for hyprland environments.lua but for sync.sh scripts in local.sh
  hl.exec_cmd(os.getenv("HOME") .. "/.config/hypr/optimized-background-motion")

  hl.exec_cmd("kitty --class kitty_main", { workspace = "1 silent" })
  hl.exec_cmd("thunderbird", { workspace = "special:email silent" })

  -- not silent, so should usually get focus autmatically
  hl.exec_cmd('kitty sh -c "rmpc play && rmpc"', { workspace = "2" })
  hl.exec_cmd("discord", { workspace = "2 silent" })

  -- WARN: --profile-directory is not documented by google but its the only thing which works
  hl.exec_cmd('google-chrome-stable --profile-directory="Profile 2"', { workspace = "1 silent" })
  -- wait 2s to ensure the first opened chrome profile is Profile 2 (for the listener up-top)
  hl.exec_cmd('sleep 2; google-chrome-stable --profile-directory="Default"', { workspace = "3 silent" })

  -- NOTE: reloading the config, there is bug in hyprland when using the default wallpapers
  -- hl.exec_cmd("sleep 1.5; hyprctl dismissnotify; hyprctl reload")
end

function m.setup()
  hl.on("hyprland.start", autostart)
end
return m

-- INFO: Find your profile path for google chrome
-- 1. Open Chrome normally using the profile you want to target.
-- 2. Type `chrome://version` into the address bar and press **Enter**.
-- 3. Look for the **Profile Path** line.
-- 4. Note the very last folder in that path (it will usually be `Default`, `Profile 1`, `Profile 2`, etc.). This is your exact profile directory name.
-- > They are usually located in "$HOME/.config/google-chrome/Default"
-- > They are usually located in "$HOME/.config/google-chrome/Profile 2"
-- > you can also find it using the filenamanger and look for the profile images
-- https://wiki.hypr.land/Configuring/Basics/Autostart/
