-- See `:help gitsigns` to understand what the configuration keys do
return {
	{
		-- require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps
		-- ROBIN: apparently has gitsign recommanded keymaps or i copied it from the min setup from the original page
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
			current_line_blame = true,
			current_line_blame_opts = {
				delay = 100,
				-- TODO: set more stuff here like alignment, white space formatter and toggle keymap
			},
		},
	},
}
