-- NOTE: supported llms and agents
-- https://codecompanion.olimorris.dev/#supported-llms-and-agents
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

				-- NOTE: Bard / Gemini
				-- chat = {
				-- 	adapter = "gemini_cli",
				-- },
				-- inline = {
				-- 	adapter = "gemini_cli",
				-- },
				-- cmd = {
				-- 	adapter = "gemini_cli",
				-- },
				-- cli = {
				-- 	adapter = "gemini_cli",
				-- },

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
				acp = {
					gemini_cli = function()
						return require("codecompanion.adapters").extend("gemini_cli", {
							defaults = {
								auth_method = "oauth-personal", -- "oauth-personal"|"gemini-api-key"|"vertex-ai"
							},
						})
					end,
				},
				http = {
					copilot = function()
						return require("codecompanion.adapters").extend("copilot", {
							schema = {
								model = {
									-- GPT-4.1 `gpt-4.1`
									-- Claude Haiku 4.5 `?`
									-- GPT-4o `gpt-4o`
									-- GPT-5 mini `gpt-5`
									-- Raptor mini (Preview) `?`
									default = "gpt-4.1",
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
