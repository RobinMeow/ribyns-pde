---@module 'lazy'
---@type LazySpec
return {
	"olimorris/codecompanion.nvim",
	version = "^19.8.0",
	opts = {},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		{
			"HakonHarnes/img-clip.nvim",
			opts = {
				filetypes = {
					codecompanion = {
						prompt_for_file_name = false,
						template = "[Image]($FILE_PATH)",
						use_absolute_path = true,
					},
				},
			},
		},
	},
}
