--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.o.termguicolors = true

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.o`

vim.o.number = true -- absolute line numbers
vim.o.relativenumber = true -- line numbers relative to cursor
--require("idle-numbers").setup()

vim.o.showmode = false -- Don't show the mode, since it's already in the status line

vim.o.breakindent = true -- Enable break indent

vim.o.undofile = true -- Save undo history

vim.opt.foldenable = true
vim.opt.foldcolumn = "1"
vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 99 -- start with all folds open

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.signcolumn = "yes" -- Keep signcolumn on by default

vim.o.updatetime = 250 -- If this many milliseconds nothing is typed the swap file will be written to disk (Default 4000)

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300 -- probably allows faster typing

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

vim.o.winborder = "rounded" -- make all floating windows rounded

vim.o.shiftwidth = 2
vim.o.tabstop = 2

vim.opt.list = true
vim.opt.listchars = {
	tab = "· ", -- first char is overriden by ident blanklint plugin if applicable
	trail = "·",
	nbsp = "␣",
	eol = "↵", -- ↵ ↲ ↲
}

-- Preview substitutions live, as you type! Whats a substitution: s%/replaceTxt/WithMe/g
-- will show the preview in the file without confirming it
vim.o.inccommand = "split"

vim.o.cursorline = true -- Show which line your cursor is on

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10 -- amount of lines to keep visible above and beneath the cursor

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
vim.o.confirm = true

-- [[ Keymaps ]]
-- Clear highlights on search when pressing <Esc> in normal mode :help hlsearch
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("t", "<Esc><Esc>", "<c-\\><c-n>")

local session = require("session")
vim.keymap.set("n", "<leader><leader>ss", session.store_session, { desc = "[ ][s]ave [s]esssion" })
vim.keymap.set("n", "<leader><leader>se", session.store_session_and_exit, { desc = "[ ][s]ave sesssion and [e]xit" })
vim.keymap.set("n", "<leader><leader>sr", session.restore, { desc = "[ ][s]ession [r]estore" })
vim.keymap.set("n", "<leader><leader>sd", session.delete_session, { desc = "[ ][s]ession [d]elete, if exists" })

-- Copy visual selection to system clipboard
vim.api.nvim_set_keymap(
	"v",
	"<leader><leader>cv",
	'"+y',
	{ desc = "[ ][ ][c]opy [v]isual selection to system clipboard" }
)
-- Copy entire buffer to system clipboard
vim.api.nvim_set_keymap("n", "<leader><leader>cb", ":%y+<CR>", { desc = "[ ][ ][c]opy [b]uffer to system clipboard" })

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Keybinds to make split navigation easier.
-- See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

require("borders")
require("floaterminal")
require("highlight-on-yank")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

require("lazy").setup({
	-- For additional information with loading, sourcing and examples see:
	-- `<space>sh` search for `lazy.nvim-plugin`
	require("plugin.snacks"),
	require("plugin.transparent"),
	"NMAC427/guess-indent.nvim",
	require("plugin.gitsigns"),
	require("plugin.indent-blankline"),
	require("plugin.diffview"),
	require("plugin.neogit"),
	require("plugin.smear-cursor"),
	require("plugin.which-key"),
	require("plugin.telescope"),
	require("plugin.dadbod"),
	require("plugin.blink_cmp"),
	require("plugin.colorscheme").catppuccin,
	require("plugin.colorscheme").gruvbox,
	require("plugin.colorscheme").vscode,
	require("plugin.colorscheme").tokyo_night,
	require("plugin.colorscheme").kanagawa,
	require("plugin.colorscheme").nightfox,
	{ "tpope/vim-fugitive" },
	require("plugin.todo-comments"),
	require("plugin.lualine"),
	require("plugin.flash-nvim"),
	require("plugin.yazi"),
	require("plugin.oil"),

	-- LSP Plugins
	{ -- dotnet .NET
		"seblyng/roslyn.nvim",
		---@module 'roslyn.config'
		---@type RoslynNvimConfig
		opts = {},
	},
	{
		-- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
		-- used for completion, annotations and signatures of Neovim apis
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		-- Main LSP Configuration
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs and related tools to stdpath for Neovim
			-- Mason must be loaded before its dependents so we need to set it up here.
			-- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
			{
				"mason-org/mason.nvim",
				opts = {
					-- dotnet required registries
					registries = {
						"github:mason-org/mason-registry",
						"github:Crashdummyy/mason-registry",
					},
				},
			},
			"mason-org/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"saghen/blink.cmp", -- capabilities
		},
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end
					map("grn", vim.lsp.buf.rename, "[R]e[n]ame")
					-- Execute a code action, usually your cursor needs to be on top of an error
					-- or a suggestion from your LSP for this to activate.
					map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })

					map("grr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

					map("gri", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

					--  To jump back, press <C-t>.
					map("grd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

					-- INFO: This is not Goto Definition, this is Goto Declaration.
					--  For example, in C this would take you to the header.
					map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

					--  Symbols are things like variables, functions, types, etc.
					map("gO", require("telescope.builtin").lsp_document_symbols, "Open Document Symbols")

					--  Similar to document symbols, except searches over your entire project.
					map("gW", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Open Workspace Symbols")

					-- Jump to the type of the word under your cursor.
					--  Useful when you're not sure what type a variable is and you want to see
					--  the definition of its *type*, not where it was *defined*.
					map("grt", require("telescope.builtin").lsp_type_definitions, "[G]oto [T]ype Definition")

					-- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
					---@param client vim.lsp.Client
					---@param method vim.lsp.protocol.Method
					---@param bufnr? integer some lsp support methods only in specific files
					---@return boolean
					local function client_supports_method(client, method, bufnr)
						if vim.fn.has("nvim-0.11") == 1 then
							return client:supports_method(method, bufnr)
						else
							return client.supports_method(method, { bufnr = bufnr })
						end
					end

					-- The following two autocommands are used to highlight references of the
					-- word under your cursor when your cursor rests there for a little while.
					--    See `:help CursorHold` for information about when this is executed
					--
					-- When you move your cursor, the highlights will be cleared (the second autocommand).
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if
						client
						and client_supports_method(
							client,
							vim.lsp.protocol.Methods.textDocument_documentHighlight,
							event.buf
						)
					then
						local highlight_augroup =
							vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
							end,
						})
					end

					-- The following code creates a keymap to toggle inlay hints in your
					-- code, if the language server you are using supports them
					--
					-- This may be unwanted, since they displace some of your code
					if
						client
						and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf)
					then
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
						end, "[T]oggle Inlay [H]ints")
					end
				end,
			})

			-- Diagnostic Config
			-- See :help vim.diagnostic.Opts
			vim.diagnostic.config({
				severity_sort = true,
				float = { border = "rounded", source = "if_many" },
				underline = { severity = vim.diagnostic.severity.ERROR },
				signs = vim.g.have_nerd_font and {
					text = {
						[vim.diagnostic.severity.ERROR] = "󰅚 ",
						[vim.diagnostic.severity.WARN] = "󰀪 ",
						[vim.diagnostic.severity.INFO] = "󰋽 ",
						[vim.diagnostic.severity.HINT] = "󰌶 ",
					},
				} or {},
				virtual_text = {
					source = "if_many",
					spacing = 2,
					format = function(diagnostic)
						local diagnostic_message = {
							[vim.diagnostic.severity.ERROR] = diagnostic.message,
							[vim.diagnostic.severity.WARN] = diagnostic.message,
							[vim.diagnostic.severity.INFO] = diagnostic.message,
							[vim.diagnostic.severity.HINT] = diagnostic.message,
						}
						return diagnostic_message[diagnostic.severity]
					end,
				},
			})

			local capabilities = require("blink.cmp").get_lsp_capabilities()

			-- Enable the following language servers
			--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
			--
			--  Add any additional override configuration in the following tables. Available keys are:
			--  - cmd (table): Override the default command used to start the server
			--  - filetypes (table): Override the default list of associated filetypes for the server
			--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
			--  - settings (table): Override the default settings passed when initializing the server.
			--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
			local servers = {
				bashls = {},
				ts_ls = {}, -- https://github.com/pmizio/typescript-tools.nvim can be considered when more speed is required
				eslint = {},
				shellcheck = {},
				shellharden = {},
				angularls = {},
				-- The preferred way to install csharp-ls is with `dotnet tool install --global csharp-ls`.
				-- csharp_ls = {}, -- could be because of other global dotnet tooling which could depend on it,
				-- and mason has its own container of installing them
				cssls = {},
				html = {},
				pyright = {},
				rust_analyzer = {},

				lua_ls = {
					-- cmd = { ... },
					-- filetypes = { ... },
					-- capabilities = {},
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
							-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
							-- diagnostics = { disable = { 'missing-fields' } },
						},
					},
				},
				roslyn = {},
			}

			-- Ensure the servers and tools above are installed
			-- in :Mason you can press `g?` for help
			-- `mason` had to be setup earlier: to configure its options see the
			-- `dependencies` table for `nvim-lspconfig` above.
			--
			-- You can add other tools here that you want Mason to install
			-- for you, so that they are available from within Neovim.
			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"prettierd",
				"prettier",
				-- bash
				"shfmt",
				"shellcheck",
				"shellharden",

				"eslint_d",
				"stylua", -- Used to format Lua code
			})
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			require("mason-lspconfig").setup({
				ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
				automatic_installation = false,
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						-- This handles overriding only values explicitly passed
						-- by the server configuration above. Useful when disabling
						-- certain features of an LSP (for example, turning off formatting for ts_ls)
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},

	{ -- Autoformat
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = "",
				desc = "[F]ormat buffer",
			},
		},
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				-- Disable "format_on_save lsp_fallback" for languages that don't
				-- have a well standardized coding style. You can add additional
				-- languages here or re-enable it for the disabled ones.
				local disable_filetypes = { c = true, cpp = true, csharp = true }
				if disable_filetypes[vim.bo[bufnr].filetype] then
					return nil
				else
					return {
						timeout_ms = 500,
						lsp_format = "fallback",
					}
				end
			end,
			formatters_by_ft = {
				lua = { "stylua" },
				-- Conform can also run multiple formatters sequentially
				-- python = { "isort", "black" },
				sh = { "shfmt", stop_after_first = true },
				javascript = { "prettierd", "prettier", stop_after_first = true },
				typescript = { "prettierd", "prettier", stop_after_first = true },
				html = { "prettierd", "prettier", stop_after_first = true },
				htmlangular = { "prettierd", "prettier", stop_after_first = true },
				css = { "prettierd", "prettier", stop_after_first = true },
				scss = { "prettierd", "prettier", stop_after_first = true },
				sass = { "prettierd", "prettier", stop_after_first = true },
			},
		},
	},

	{ -- Collection of various small independent plugins/modules
		"echasnovski/mini.nvim",
		config = function()
			-- Better Around/Inside textobjects
			-- Examples:
			--  - va)  - [V]isually select [A]round [)]paren
			--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
			--  - ci'  - [C]hange [I]nside [']quote
			require("mini.ai").setup({ n_lines = 500 })

			-- Add/delete/replace surroundings (brackets, quotes, etc.)
			-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
			-- - sd'   - [S]urround [D]elete [']quotes
			-- - sr)'  - [S]urround [R]eplace [)] [']
			-- require("mini.surround").setup()
			-- TODO: probably replace with surround with plugin
		end,
	},
	{ -- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		main = "nvim-treesitter.config", -- Sets main module to use for opts (wsl = config | linux = configs)
		-- [[ Configure Treesitter ]] See `:help nvim-treesitter`
		opts = {
			ensure_installed = {
				-- these parsers must always be installed according to treestitter
				"c",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"markdown",
				"markdown_inline",

				-- my chosen parsers or from kickstart
				"bash",
				"diff",
				"html",
				"luadoc",
			},
			-- Autoinstall languages that are not installed
			auto_install = true,
			highlight = {
				enable = true,
				-- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
				--  If you are experiencing weird indenting issues, add the language to
				--  the list of additional_vim_regex_highlighting and disabled languages for indent.
				additional_vim_regex_highlighting = { "ruby" },
			},
			indent = { enable = true, disable = { "ruby" } },
		},
		-- There are additional nvim-treesitter modules that you can use to interact
		-- with nvim-treesitter. You should go explore a few and see what interests you:
		--
		--    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
		--    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
		--    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
	},

	--  Here are some example plugins that I've included in the Kickstart repository.
	--  Uncomment any of the lines below to enable them (you will need to restart nvim).
	--
	-- require 'kickstart.plugins.debug',
	-- require 'kickstart.plugins.indent_line',
	-- require 'kickstart.plugins.lint',
	-- require 'kickstart.plugins.autopairs',
	-- require 'kickstart.plugins.neo-tree',
}, {
	ui = {
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
		border = "rounded",
	},
})
vim.cmd("TransparentEnable")

local function get_kanagawa_variant()
	local hour = tonumber(os.date("%H"))
	local min = tonumber(os.date("%M"))
	local currentTime = hour + (min / 60)

	-- 10:00 AM to 5:30 PM (17.5 in decimal)
	if currentTime >= 10 and currentTime < 17.5 then
		return "kanagawa-wave"
	else
		return "kanagawa-dragon"
	end
end

vim.cmd("colorscheme " .. get_kanagawa_variant())

-- show diagnostic beneath cursor while resting
-- vim.api.nvim_create_autocmd("CursorHold", {
-- 	callback = function()
-- 		vim.diagnostic.open_float(nil, {
-- 			focusable = false,
-- 			border = "rounded", -- This will use your FloatBorder highlight
-- 			source = "always",
-- 			prefix = " ",
-- 			scope = "cursor",
-- 		})
-- 	end,
-- })
