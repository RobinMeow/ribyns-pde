---@module 'lazy'
---@type LazySpec
return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = function()
		require("snacks-notifier")
		return {
			bigfile = { enabled = false },
			dashboard = {
				enabled = true,
				pane_gap = 2,
				sections = {
					-- Tip: you can also dynamically hide some sections if your screen is too small for example. by adding an enabled function and then checking vim.o.columns.
					{
						section = "terminal",
						cmd = "cat " .. vim.fn.stdpath("config") .. "/eeyore-59w-35h.ascii",
						height = 35, -- its generated with the --height 35 flag width is assumed
						width = 60,
					},
					{
						pane = 2,

						text = [[ ____  _ _
|  _ \(_) |__  _   _ _ __
| |_) | | '_ \| | | | '_ \
|  _ <| | |_) | |_| | | | |
|_| \_\_|_.__/ \__, |_| |_|
               |___/]],
						padding = 1,
					},
					{
						section = "startup", -- how long nvim took to startup
						padding = 1,
						pane = 2,
					},
					{
						section = "terminal",
						cmd = "fortune | cowsay | lolcat --freq 0.2",
						pane = 2,
					},
				},
			},
			explorer = { enabled = false },
			indent = { enabled = false },
			input = { enabled = false },
			picker = { enabled = false },
			notifier = {
				enabled = true,
			},
			quickfile = { enabled = false },
			scope = { enabled = false },
			scroll = { enabled = false },
			statuscolumn = { enabled = false },
			words = { enabled = false },
		}
	end,
}
