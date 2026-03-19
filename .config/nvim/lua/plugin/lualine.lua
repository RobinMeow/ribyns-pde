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
				lualine_a = {
					{
						"tabs",
						tab_max_length = 40, -- Maximum width of each tab. The content will be shorten dynamically (example: apple/orange -> a/orange)
						max_length = vim.o.columns / 3, -- Maximum width of tabs component.
						-- Note:
						-- It can also be a function that returns
						-- the value of `max_length` dynamically.
						mode = 1, -- 0: Shows tab_nr
						-- 1: Shows tab_name
						-- 2: Shows tab_nr + tab_name

						path = 0, -- 0: just shows the filename
						-- 1: shows the relative path and shorten $HOME to ~
						-- 2: shows the full path
						-- 3: shows the full path and shorten $HOME to ~

						-- Automatically updates active tab color to match color of other components (will be overidden if buffers_color is set)
						use_mode_colors = false,

						tabs_color = {
							-- Same values as the general color option can be used here.
							active = "lualine_a_normal", -- Color for active tab.
							inactive = "lualine_a_inactive", -- Color for inactive tab.
						},

						show_modified_status = true, -- Shows a symbol next to the tab name if the file has been modified.
						symbols = {
							modified = "[+]", -- Text to show when the file is modified.
						},

						fmt = function(name, context)
							-- Show + if the active buffer is modified in tab
							local buflist = vim.fn.tabpagebuflist(context.tabnr)
							local winnr = vim.fn.tabpagewinnr(context.tabnr)
							local bufnr = buflist[winnr]
							local mod = vim.fn.getbufvar(bufnr, "&mod")

							return name .. (mod == 1 and " +" or "")
						end,
					},
				},
				-- lualine_b = {},
				-- maybe in the future when i have keymaps for buffers
				-- do not show branch, in favor for more space on tabs, which display .. when abbreviated
				-- lualine_y = { "branch" },
				-- lualine_z = {},
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
