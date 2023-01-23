-- better up/down
vim.keymap.set('n', '<down>', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set('n', '<up>', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Split navigation
vim.keymap.set('n', '<C-up>', '<C-w><up>', {})
vim.keymap.set('n', '<C-down>', '<C-w><down>', {})
vim.keymap.set('n', '<C-right>', '<C-w><right>', {})
vim.keymap.set('n', '<C-left>', '<C-w><left>', {})

-- Resize window using <shift> + arrow keys
vim.keymap.set('n', '<S-Up>', '<cmd>resize +2<cr>', { desc = 'Increase window height' })
vim.keymap.set('n', '<S-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease window height' })
vim.keymap.set('n', '<S-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease window width' })
vim.keymap.set('n', '<S-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase window width' })
