-- EXAMPLE get desc: using `hyprctl devices` (which is shorthand for `hyprctl devices all`)
local front_monitor = "desc:Asus MODEL1 0x00000001"
local left_monitor = "desc:BenQ MODEL2 0x00000002"

hl.workspace_rule({ workspace = "1", persistent = true, monitor = front_monitor })
hl.workspace_rule({ workspace = "2", persistent = true, monitor = left_monitor })

local m = {}
m.enabled = false
function m.setup()
  -- workspaces are positioned left-to-right `auto-right` by default

  -- NOTE: using auto detection (failed to use 144hz for me)
  --
  -- hl.monitor({
  --   output = "",
  --   mode = "preferred",
  --   position = "auto-left",
  --   scale = "auto",
  -- })

  -- NOTE: example for using monitor specific setups
  -- based on ports (I recommend using serial numbers in some cases)
  --
  -- Left Monitor
  -- hl.monitor({
  --   output = "DP-3",
  --   mode = "2560x1440@143.91",
  --   position = "0x0",
  --   scale = "1",
  -- })

  -- Front Monitor
  -- hl.monitor({
  --   output = "DP-1",
  --   mode = "2560x1440@143.91",
  --   position = "2560x0",
  --   scale = "1",
  -- })

  -- NOTE: example using description (and serial no)
  -- the description field in `hyprctl monitors` is already using this format
  --
  -- Front Monitor
  -- hl.monitor({
  --   -- output format for using serial: "desc:make model serial"
  --   output = "desc:Asus ABCMODEL 0x00000000",
  --   mode = "2560x1440@143.91",
  --   position = "2560x0",
  --   scale = "1",
  -- })

  -- Left Monitor
  -- hl.monitor({
  --   -- output format for using serial: "desc:make model serial"
  --   output = "desc:BenQ ABCMODEL 0x00000001",
  --   mode = "2560x1440@143.91",
  --   position = "0x0",
  --   scale = "1",
  -- })

  -- NOTE: example disable a monitor
  --
  -- hl.monitor({ output = "name", disabled = true })
end
return m
