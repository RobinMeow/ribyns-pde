-- https://github.com/nvim-lualine/lualine.nvim
---@module 'lazy'
---@type LazySpec
return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = (function()
		-- | A | B | C        X | Y | Z |

		return {
			-- theme = "catppuccin", -- TODO: use catppuccin
			options = {
				-- defaults but i might remove them if i need more space
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },

				-- When set to true, if you have configured lualine for displaying tabline
				-- then tabline will always show. If set to false, then tabline will be displayed
				-- only when there are more than 1 tab. (see :h showtabline)
				always_divide_middle = true, -- default but i might need to change this when i put something large in there
			},
			tabline = {
				lualine_a = { "branch" },
				-- maybe in the future when i have keymaps for buffers
				lualine_z = {
					"datetime",
					-- options: default, us, uk, iso, or your own format string ("%H:%M", etc..)
					-- style = "default",
				},
				-- lualine_z = { "buffers" },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "diff", { "diagnostics" } },
				lualine_c = { { "filename", path = 1 } }, -- path=1 relative file path
				lualine_x = {
					"encoding",
					"fileformat",
					"filetype",
				},
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {
					{ "filename", path = 1 },
				},
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			winbar = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = {},
				lualine_y = {
					function()
						-- returns the lsp names lspA | lspB
						local clients = vim.lsp.get_clients({ bufnr = 0 })
						if #clients == 0 then
							return "no-lsp"
						end
						local names = {}
						for _, client in ipairs(clients) do
							table.insert(names, client.name)
						end
						return table.concat(names, " | ")
					end,
				},
				lualine_z = {},
			},
			inactive_winbar = {
				lualine_c = {
					"filename",
				},
				lualine_y = {
					function()
						-- returns the lsp names lspA | lspB
						local clients = vim.lsp.get_clients({ bufnr = 0 })
						if #clients == 0 then
							return "no-lsp"
						end
						local names = {}
						for _, client in ipairs(clients) do
							table.insert(names, client.name)
						end
						return table.concat(names, " | ")
					end,
				},
			},
			extensions = {},
		}
	end)(),
}
