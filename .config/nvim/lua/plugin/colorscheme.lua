local M = {}

---@module 'lazy'
---@type LazySpec
M.vscode = {
	"Mofiqul/vscode.nvim",
	config = function()
		vim.cmd.colorscheme("vscode")
	end,
}

---@module 'lazy'
---@type LazySpec
M.catppuccin = {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "mocha", -- Change this to 'frappe', 'macchiato', or 'latte' if desired
			no_italic = true,
			integrations = {
				-- integrate on more stuff like cmp, gitsigns, etc..
			},
		})
	end,
}

---@module 'lazy'
---@type LazySpec
M.gruvbox = { "ellisonleao/gruvbox.nvim" }

return M
