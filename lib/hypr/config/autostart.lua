-- https://wiki.hypr.land/Configuring/Basics/Autostart/
local m = {}

local function default_autostart()
  -- daemons / jobs / etc.
  hl.exec_cmd("mpd") -- uses daemon by default otherwise --no-daemon or --systemd
  hl.exec_cmd("wob_volume listen")
  hl.exec_cmd("hyprpaper")
  -- rofi does not use daemons

  -- apps
  hl.exec_cmd("kitty", { workspace = "1" })
end

function m.setup()
  local ok, _local = pcall(require, "local.autostart")

  hl.on("hyprland.start", function()
    -- run these always regardless of per-machine-local setup

    -- set dark themes
    hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface accent-color 'orange'")
    hl.exec_cmd("/usr/local/libexec/xdg-desktop-portal-termfilechooser -r")

    -- https://wiki.hypr.land/Useful-Utilities/Systemd-start/#hyprland-sessiontarget
    hl.exec_cmd("systemctl --user start hyprland-session.target")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    -- now using mpvpaper, so each machine has to decide on their own
    -- hl.exec_cmd("hyprpaper")
    hl.exec_cmd("dunst")
  end)

  hl.on("hyprland.shutdown", function()
    -- https://wiki.hypr.land/Useful-Utilities/Systemd-start/#hyprland-sessiontarget
    -- uses a blocking exec function and sleeps a bit to give things time to close
    os.execute("systemctl --user stop hyprland-session.target && sleep 0.1")
    os.execute("systemctl --user stop hyprpolkitagent && sleep 0.1")
    -- you can kill troublesome apps which don't want to close:
    -- os.execute("pkill wallpaperthing; systemctl --user stop hyprland-session.target && sleep 0.1")
  end)

  if ok and _local.enabled == true then
    _local.setup()
  else
    -- a sensible default
    hl.on("hyprland.start", default_autostart)
  end
end
return m
