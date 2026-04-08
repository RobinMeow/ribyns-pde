---@module 'lazy'
---@type LazySpec
return {
	"olimorris/codecompanion.nvim",
	version = "^19.8.0",
	opts = {
		interactions = {
			chat = {
				adapter = "mistral",
				model = "devstral-2",
			},
		},
		adapters = {
			http = {
				mistral = function()
					return require("codecompanion.adapters").extend("mistral", {
						env = {
							api_key = os.getenv("MISTRAL_API_KEY"),
						},
					})
				end,
			},
		},
		-- NOTE: The log_level is in `opts.opts`
		opts = {
			log_level = "DEBUG",
		},
	},
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
