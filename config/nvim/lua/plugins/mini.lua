return {
	{ -- Collection of various small independent plugins/modules
		-- TODO: learn nvim basics first. dont think i ever used those
		-- :h text-objects :h operator :h .
		-- and then decide between mini and nvim surround
		enabled = false,
		"echasnovski/mini.nvim",
		config = function()
			-- Better Around/Inside textobjects
			-- Examples:
			--  - va)  - [V]isually select [A]round [)]paren
			--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
			--  - ci'  - [C]hange [I]nside [']quote
			require("mini.ai").setup({
				mappings = {
					-- NOTE: avoid conflicts with the built-in selection mappings on nvim 0.12
					around_next = "aa",
					inside_next = "ii",
				},
				n_lines = 500,
			})

			-- Add/delete/replace surroundings (brackets, quotes, etc.)
			-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
			-- - sd'   - [S]urround [D]elete [']quotes
			-- - sr)'  - [S]urround [R]eplace [)] [']
			-- require("mini.surround").setup()
		end,
	},
}
