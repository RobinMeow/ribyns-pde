local M = {}

---@module 'lazy'
---@type LazySpec
M.vscode = {
	"Mofiqul/vscode.nvim",
	-- config = function()
	-- 	vim.cmd.colorscheme("vscode")
	-- end,
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

M.tokyo_night = {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	opts = {},
}

M.kanagawa = {
	"rebelot/kanagawa.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("kanagawa").setup({
			commentStyle = { italic = false },
			keywordStyle = { italic = false },
			-- statementStyle = { bold = false },
			typeStyle = {
				italic = false,
				-- bold = false,
			},
			-- variablebuiltinStyle = { italic = false },
			specialitalic = false,
			-- specialbold = false,
			overrides = function(colors) -- add/modify highlights
				local theme = colors.theme
				return {
					-- transparent floating windows
					NormalFloat = { bg = "none" },
					FloatBorder = { bg = "none" },
					FloatTitle = { bg = "none" },

					-- Save an hlgroup with dark background and dimmed foreground
					-- so that you can use it where your still want darker windows.
					-- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
					-- NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

					-- Popular plugins that open floats will link to NormalFloat by default;
					-- set their background accordingly if you wish to keep them dark and borderless
					-- LazyNormal = { fg = theme.ui.fg_dim },
					-- MasonNormal = { fg = theme.ui.fg_dim },

					-- borderless telescope
					-- TelescopeTitle = { fg = theme.ui.special, bold = true },
					-- TelescopePromptBorder = { fg = theme.ui.bg_p1 },
					-- TelescopeResultsNormal = { fg = theme.ui.fg_dim },
					-- TelescopeResultsBorder = { fg = theme.ui.bg_m1 },
					-- TelescopePreviewBorder = { fg = theme.ui.bg_dim },
				}
			end,
		})
		vim.cmd.colorscheme("kanagawa-wave")
	end,
}

M.nightfox = { "EdenEast/nightfox.nvim", lazy = false, priority = 1000, opts = {} }

return M
