return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons", -- optional, but recommended
		},
		lazy = false, -- neo-tree will lazily load itself
		keys = {
			{ "<C-e>", ":Neotree reveal<CR>", desc = "NeoTree reveal", silent = true },
			{ "\\", ":Neotree reveal<CR>", desc = "NeoTree reveal", silent = true },
		},
		--@module 'neo-tree'
		---@type neotree.Config
		opts = {
			filesystem = {
				window = {
					mappings = {
						["<C-e>"] = "close_window",
						["\\"] = "close_window",
					},
				},
			},
		},
	},
}
