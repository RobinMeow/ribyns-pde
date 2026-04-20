return {
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    config = function()
      local function load_domain()
        local cwd = vim.fn.getcwd()
        local path = cwd

        -- walk up to find .nvim/dadbod folder
        while path ~= "/" do
          local dadbod_path = path .. "/.nvim/dadbod"
          if vim.fn.isdirectory(dadbod_path) == 1 then
            local connections_file = dadbod_path .. "/connections.lua"
            if vim.fn.filereadable(connections_file) == 1 then
              local connections = dofile(connections_file)
              if connections then
                vim.g.dbs = connections
                for _, conn in ipairs(connections) do
                  vim.notify("Conn: " .. conn.name, vim.log.levels.INFO)
                end
              else
                vim.notify(
                  "Failed to load Dadbod connections from " .. connections_file .. "\n" .. tostring(connections),
                  vim.log.levels.ERROR,
                  { title = "Dadbod Loader" }
                )
              end
            end

            -- ensure saves folder exists
            local save_dir = dadbod_path .. "/saves"
            if vim.fn.isdirectory(save_dir) == 0 then
              vim.fn.mkdir(save_dir, "p")
            end
            vim.g.db_ui_save_location = save_dir

            return
          end
          path = vim.fn.fnamemodify(path, ":h")
        end
      end

      local ok = pcall(load_domain)
      if not ok then
        vim.notify("failed to load domains", vim.log.levels.ERROR, { title = "Dadbod Loader" })
      end

      -- reload domains on dir change. autocmd only runs when dbui has been invoked once.
      vim.api.nvim_create_autocmd("DirChanged", {
        callback = function()
          load_domain()
        end,
      })
    end,
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },
}
