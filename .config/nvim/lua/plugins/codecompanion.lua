-- NOTE: supported llms and agents
-- https://codecompanion.olimorris.dev/#supported-llms-and-agents
local default_adapter = os.getenv("CODE_COMPANION_DEFAULT_ADAPTER") or "ollama"
local ollama_model = os.getenv("CODE_COMPANION_OLLAMA_MODEL") or "qwen2.5-coder:3b"
-- gemini_cli
-- copilot
-- mistral_vibe (acp)
-- mistral (http)
-- ollama

return {
	{
		"olimorris/codecompanion.nvim",
		version = "^19.8.0",
		opts = {
			interactions = {
				-- Chat: A buffer where you can converse with an LLM (:CodeCompanionChat)
				chat = {
					adapter = default_adapter,
				},
				-- Inline - An inline interaction that can write code directly into a buffer (:CodeCompanion)
				inline = {
					adapter = default_adapter,
				},
				-- Cmd - Create Neovim commands in the command-line (:CodeCompanionCmd)
				cmd = {
					adapter = default_adapter,
				},
				-- CLI - A terminal wrapper around agent CLI tools such a Claude Code or Opencode (:CodeCompanionCLI)
				cli = {
					adapter = default_adapter,
				},
			},
			adapters = {
				acp = {
					gemini_cli = function()
						return require("codecompanion.adapters").extend("gemini_cli", {
							defaults = {
								auth_method = "oauth-personal", -- "oauth-personal"|"gemini-api-key"|"vertex-ai"
							},
						})
					end,
					mistral_vibe = function()
						return require("codecompanion.adapters").extend("mistral_vibe", {
							schema = {
								model = {
									default = "devstral-2",
								},
							},
						})
					end,
				},
				http = {
					ollama = function()
						return require("codecompanion.adapters").extend("ollama", {
							schema = {
								model = {
									default = ollama_model,
								},
							},
						})
					end,
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
							-- NOTE: havent tried this one yet
							-- schema = {
							-- 	model {
							-- 		default = "devstral-2",
							-- 	},
							-- },
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
