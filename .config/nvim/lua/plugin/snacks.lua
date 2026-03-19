---@module 'lazy'
---@type LazySpec
return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	-- @type snacks.Config
	opts = function()
		require("snacks-notifier")
		return {
			bigfile = { enabled = false },
			terminal = {
				win = {
					position = "float",
					border = "rounded",
					height = 0.4,
					width = vim.o.columns,
					zindex = 50,
					row = vim.o.lines,
				},
			},
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
						text = "Thanks for noticin' me.",
						padding = 1, -- i use it like bottom padding. doesnt seem to do anything else.
					},
					{
						section = "startup", -- how long nvim took to startup
					},
				},
			},
			explorer = { enabled = false },
			indent = { enabled = false },
			input = { enabled = false },
			picker = { enabled = false },
			notifier = {
				timeout = 5000,
				margin = {
					top = 1, -- prevent it from rendering on top of winbar
				},
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
