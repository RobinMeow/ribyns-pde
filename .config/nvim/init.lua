vim.o.scrolloff = 9 -- amount of lines to keep visible above and beneath the cursor
vim.o.number = true -- absolute line numbers
vim.o.relativenumber = true -- line numbers relative to cursor

-- highlight on yank (quick visual feedback)
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlint on yank',
  group = vim.api.nvim_create_augroup('highlight_on_yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
