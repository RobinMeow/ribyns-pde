---@module 'lazy'
---@type LazySpec
return {
	{
		"olimorris/codecompanion.nvim",
		version = "^19.8.0",
		opts = {
			interactions = {
				-- Chat: A buffer where you can converse with an LLM (:CodeCompanionChat)
				chat = {
					adapter = "ollama",
				},
				-- Inline - An inline interaction that can write code directly into a buffer (:CodeCompanion)
				inline = {
					adapter = "ollama",
				},
				-- Cmd - Create Neovim commands in the command-line (:CodeCompanionCmd)
				cmd = {
					adapter = "ollama",
				},
				-- CLI - A terminal wrapper around agent CLI tools such a Claude Code or Opencode (:CodeCompanionCLI)
				cli = {
					adapter = "ollama",
				},

				-- NOTE: Github Copilot
				-- chat = {
				-- 	adapter = "copilot",
				-- },
				-- inline = {
				-- 	adapter = "copilot",
				-- },
				-- cmd = {
				-- 	adapter = "copilot",
				-- },
				-- cli = {
				-- 	adapter = "copilot",
				-- },

				-- NOTE: Mistral
				-- chat = {
				-- 	adapter = "mistral_vibe",
				-- 	model = "devstral-2",
				-- },
				-- cli = {
				-- 	adapter = "mistral_vibe",
				-- 	model = "devstral-2",
				-- },
				-- inline = {
				-- 	adapter = "mistral",
				-- },
			},
			adapters = {
				ollama = function()
					return require("codecompanion.adapters").extend("ollama", {
						schema = {
							model = {
								default = "qwen2.5-coder:3b",
							},
						},
					})
				end,
				http = {
					copilot = function()
						return require("codecompanion.adapters").extend("copilot", {
							schema = {
								model = {
									-- GPT-4.1
									-- Claude Haiku 4.5
									-- GPT-4o
									-- GPT-5 mini
									-- Raptor mini (Preview)
									default = "Claude Haiku 4.5",
								},
							},
						})
					end,
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
	},
}
