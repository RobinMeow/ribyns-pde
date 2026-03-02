---@module 'lazy'
---@type LazySpec
return {
	"sindrets/diffview.nvim",
	opts = {
		view = {
			default = { layout = "diff2_horizontal" },
			file_history = { layout = "diff2_horizontal" },
			merge_tool = { layout = "diff3_mixed" },
		},
		file_panel = {
			listing_style = "list", -- One of 'list' or 'tree'
		},
		win_config = { -- See |diffview-config-win_config|
			position = "left",
			width = 35,
			win_opts = {},
		},
	},
}
