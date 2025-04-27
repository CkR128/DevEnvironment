-- Go to the next diagnostic, even if on the same line
vim.keymap.set('n', ']e', function()
  vim.diagnostic.goto_next({ float = true })
end, { desc = "Go to next diagnostic" })

-- Go to the previous diagnostic, even if on the same line
vim.keymap.set('n', '[e', function()
  vim.diagnostic.goto_prev({ float = true })
end, { desc = "Go to previous diagnostic" })
