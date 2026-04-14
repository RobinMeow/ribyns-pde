-- file serves as an example and will never be synced. its expected to be present locally
local wezterm = require("wezterm")
local M = {}

function M.load_projectname_workspace(window, pane)
	local gui_window = window:set_workspace("example")

	-- Tab 1: Primary Worktree
	pane:send_text("cd ~/example/data-sync-wt/21711-v2-create-machine\n")
	pane:send_text("git l\n")

	-- Tab 2: Main Sync
	local _, pane2, _ = window:spawn_tab({})
	pane2:send_text("cd ~/example/data-sync\n")
	pane2:send_text("git l\n")

	-- Tab 3: Dev Worktree
	local _, pane3, _ = window:spawn_tab({})
	pane3:send_text("cd ~/example/data-sync-wt/dev\n")
	pane3:send_text("git l\n")
end

-- this is called by .wezterm.lua
function M.setup(window, pane)
	M.load_projectname_workspace(window, pane)
end

return M
