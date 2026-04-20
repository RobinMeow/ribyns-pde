return {
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    opts = {
      -- Choose a preset style for diagnostic appearance
      -- Available: "modern", "classic", "minimal", "powerline", "ghost", "simple", "nonerdfont", "amongus"
      preset = "powerline", -- default: modern

      -- List of filetypes to disable the plugin for
      disabled_ft = {},

      options = {
        -- Display the source of diagnostics (e.g., "lua_ls", "pyright")
        show_source = {
          enabled = true, -- Enable showing source names. default: false
          if_many = false, -- Only show source if multiple sources exist for the same diagnostic
        },

        -- Use icons from vim.diagnostic.config instead of preset icons
        use_icons_from_diagnostic = false,

        -- Throttle update frequency in milliseconds to improve performance
        -- Higher values reduce CPU usage but may feel less responsive
        -- Set to 0 for immediate updates (may cause lag on slow systems)
        throttle = 40, -- default: 20

        -- Control how diagnostic messages are displayed
        -- NOTE: When using display_count = true, you need to enable multiline diagnostics with multilines.enabled = true
        --       If you want them to always be displayed, you can also set multilines.always_show = true.
        add_messages = {
          messages = true, -- Show full diagnostic messages
          display_count = false, -- Show diagnostic count instead of messages when cursor not on line
          use_max_severity = false, -- When counting, only show the most severe diagnostic
          show_multiple_glyphs = true, -- Show multiple icons for multiple diagnostics of same severity
        },

        -- Settings for multiline diagnostics
        multilines = {
          enabled = false, -- Enable support for multiline diagnostic messages
          always_show = false, -- Always show messages on all lines of multiline diagnostics
          trim_whitespaces = false, -- Remove leading/trailing whitespace from each line
          tabstop = 4, -- Number of spaces per tab when expanding tabs
          severity = nil, -- Filter multiline diagnostics by severity (e.g., { vim.diagnostic.severity.ERROR })
        },

        -- Display related diagnostics from LSP relatedInformation
        show_related = {
          enabled = true, -- Enable displaying related diagnostics
          max_count = 3, -- Maximum number of related diagnostics to show per diagnostic
        },

        -- Handle messages that exceed the window width
        overflow = {
          mode = "wrap", -- "wrap": split into lines, "none": no truncation, "oneline": keep single line
          padding = 0, -- Extra characters to trigger wrapping earlier
        },

        -- Virtual text display priority
        -- Higher values appear above other plugins (e.g., GitBlame)
        virt_texts = {
          priority = 2048,
        },

        -- Remove severities you don't want to display
        severity = {
          vim.diagnostic.severity.ERROR,
          vim.diagnostic.severity.WARN,
          vim.diagnostic.severity.INFO,
          vim.diagnostic.severity.HINT,
        },
      },
    },
  },
  -- make sure to add this option to lspconfig
  -- {
  -- 	"neovim/nvim-lspconfig",
  -- 	opts = { diagnostics = { virtual_text = false } },
  -- },
}

-- example keybinds for the future:
-- vim.keymap.set("n", "<leader>de", "<cmd>TinyInlineDiag enable<cr>", { desc = "Enable diagnostics" })
-- vim.keymap.set("n", "<leader>dd", "<cmd>TinyInlineDiag disable<cr>", { desc = "Disable diagnostics" })
-- vim.keymap.set("n", "<leader>dt", "<cmd>TinyInlineDiag toggle<cr>", { desc = "Toggle diagnostics" })
-- vim.keymap.set("n", "<leader>dc", "<cmd>TinyInlineDiag toggle_cursor_only<cr>", { desc = "Toggle cursor-only diagnostics" })
-- vim.keymap.set("n", "<leader>dr", "<cmd>TinyInlineDiag reset<cr>", { desc = "Reset diagnostic options" })
