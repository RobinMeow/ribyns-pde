---@module 'lazy'
---@type LazySpec
return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	---@module "ibl"
	---@type ibl.config
	opts = {
		debounce = 100,
		indent = { char = "▏", tab_char = "▏" },
		whitespace = { remove_blankline_trail = false },
		scope = { enabled = false },
	},
}
