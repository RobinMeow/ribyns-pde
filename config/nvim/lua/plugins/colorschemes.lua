return {
  {
    "Mofiqul/vscode.nvim",
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- Change this to 'frappe', 'macchiato', or 'latte' if desired
        no_italic = true,
        integrations = {
          -- integrate on more stuff like cmp, gitsigns, etc..
        },
      })
    end,
  },
  { "ellisonleao/gruvbox.nvim" },
  {
    "folke/tokyonight.nvim",
    opts = {},
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("kanagawa").setup({
        -- remove gutter bg
        colors = {
          theme = {
            all = {
              ui = {
                bg_gutter = "none",
              },
            },
          },
        },

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
          local palette = colors.palette
          -- palette:
          -- surimiOrange
          -- oniViolet
          -- sakuraPink
          -- waveAqua1 (surprisingly good, but I dont like the cyan)
          local violence = "#6a48a0" -- strong slightly dark violet
          local border_color = violence
          return {
            -- transparent floating windows
            NormalFloat = { bg = "none" },
            FloatBorder = { bg = "none", fg = border_color },
            FloatTitle = { bg = "none" },

            TelescopeBorder = { fg = border_color },
            TelescopePromptBorder = { fg = border_color },
            TelescopeResultsBorder = { fg = border_color },
            TelescopePreviewBorder = { fg = border_color },
          }
        end,
      })
    end,
  },
  { "EdenEast/nightfox.nvim", opts = {} },
}
