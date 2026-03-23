-- comment in, if desired (when project is warning heavy)
-- vim.g.dotnet_errors_only = true

-- exclude file path to make the quickfix list less noisy
-- vim.g.dotnet_show_project_file = false

-- Build and check errors for .NET projects
vim.keymap.set("n", "<leader>dc", ":compiler dotnet<CR>:make<CR>", {
	desc = "[d]otnet [c]ompile",
	silent = true,
})
