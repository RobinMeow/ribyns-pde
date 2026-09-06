local m = {}
m.enabled = true

-- prevent discord from stealing focus on startup
hl.window_rule({ match = { class = "discord" }, no_initial_focus = true })
hl.on("window.open", function(window)
  if window.class == "discord" then
    hl.dispatch(hl.dsp.window.move({
      workspace = "1",
      follow = false,
      silent = true,
      window = window,
    }))
  end
end)

local function autostart()
  hl.exec_cmd("mpd")
  hl.exec_cmd("wob_volume listen")
  hl.exec_cmd("hyprpaper")
  hl.exec_cmd(os.getenv("HOME") .. "/.config/hypr/optimized-background-motion")

  -- special
  hl.exec_cmd("thunderbird", { workspace = "special:email silent", no_initial_focus = true })

  -- workspace 1 (left monitor)
  hl.exec_cmd('kitty sh -c "rmpc play && rmpc"', { workspace = "1 silent", no_initial_focus = true })
  hl.exec_cmd("discord", { workspace = "1 silent", no_initial_focus = true })

  -- workspace 2 (front monitor)
  hl.exec_cmd("kitty --class kitty_main", { workspace = "2" }) -- inital focus
  hl.exec_cmd("firefox", { workspace = "2 silent", no_initial_focus = true })
end

function m.setup()
  hl.on("hyprland.start", autostart)
end

return m
