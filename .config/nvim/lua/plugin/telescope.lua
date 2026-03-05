---@module 'lazy'
---@type LazySpec
return { -- Fuzzy Finder (files, lsp, etc)
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ -- If encountering errors, see telescope-fzf-native README for installation instructions
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{ "nvim-telescope/telescope-ui-select.nvim" },
		{ "nvim-tree/nvim-web-devicons", enabled = true }, -- requires nerd font
	},
	config = function()
		-- open available keybinds help:
		--  - Insert mode: <c-/>
		--  - Normal mode: ?

		-- See `:help telescope` and `:help telescope.setup()`
		require("telescope").setup({
			-- `:help telescope.setup()`
			-- defaults = {
			--   mappings = {
			--     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
			--   },
			-- },
			pickers = {
				colorscheme = { enable_preview = true },
				diagnostics = {
					theme = "ivy", -- dropdown, ivy, cursor
				},
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
			},
		})

		-- Enable Telescope extensions if they are installed
		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")

		-- See `:help telescope.builtin`
		local builtin = require("telescope.builtin")

		local function SearchCurrentDirectory()
			local current_file = vim.fn.expand("%:p")

			-- Check if the buffer is a file
			if current_file == "" or vim.fn.filereadable(current_file) == 0 then
				-- Fallback to regular find_files
				builtin.find_files()
				return
			end

			local currWorkingDir = vim.fn.expand("%:p:h")

			builtin.find_files(require("telescope.themes").get_ivy({
				cwd = currWorkingDir,
				prompt_title = "Current Buffer's Directory",
			}))
		end

		vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
		vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps (which_key i => C-/ n => ?)" })
		vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
		vim.keymap.set("n", "<leader>srg", builtin.registers, { desc = "[S]earch [R]e[G]isters" })
		vim.keymap.set("n", "<leader>sgf", builtin.git_files, { desc = "[S]earch [G]it [F]iles" })
		vim.keymap.set("n", "<leader>si", function()
			builtin.find_files({ hidden = false, no_ignore = true, no_ignore_parent = true })
		end, { desc = "[s]earch [i]gnored" })
		vim.keymap.set("n", "<leader>scd", SearchCurrentDirectory, { desc = "[S]earch [C]urrent [D]irectory" })
		vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
		vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
		vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
		vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
		vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
		vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Old Files ("." for repeat)' })
		vim.keymap.set("n", "<leader>eb", builtin.buffers, { desc = "Search [E]xisting [B]uffers" })
		vim.keymap.set("n", "<leader><leader>cs", builtin.colorscheme, { desc = "[ ][ ][c]olor[s]cheme" })

		-- Slightly advanced example of overriding default behavior and theme
		vim.keymap.set("n", "<leader>/", function()
			-- You can pass additional configuration to Telescope to change the theme, layout, etc.
			builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				winblend = 10,
				previewer = false,
			}))
		end, { desc = "[/] Fuzzily search in current buffer" })

		-- It's also possible to pass additional configuration options.
		--  See `:help telescope.builtin.live_grep()` for information about particular keys
		vim.keymap.set("n", "<leader>s/", function()
			builtin.live_grep({
				grep_open_files = true,
				prompt_title = "Live Grep in Open Files",
			})
		end, { desc = "[S]earch [/] in Open Files" })

		-- Shortcut for searching your Neovim configuration files
		vim.keymap.set("n", "<leader>sn", function()
			builtin.find_files({ cwd = vim.fn.stdpath("config") })
		end, { desc = "[S]earch [N]eovim files" })
	end,
}
