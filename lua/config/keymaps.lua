-- better up/down
vim.keymap.set('n', '<Down>', "v:count ? 'j' : 'gj'", { expr = true, silent = true })
vim.keymap.set('n', '<Up>', "v:count ? 'k' : 'gk'", { expr = true, silent = true })

-- Split navigation
vim.keymap.set('n', '<C-Up>', '<C-w><Up>', {})
vim.keymap.set('n', '<C-Down>', '<C-w><Down>', {})
vim.keymap.set('n', '<C-Right>', '<C-w><Right>', {})
vim.keymap.set('n', '<C-Left>', '<C-w><Left>', {})

-- Resize window using <shift> + arrow keys
vim.keymap.set('n', '<S-Up>', '<cmd>resize +2<cr>', { desc = 'Increase window height' })
vim.keymap.set('n', '<S-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease window height' })
vim.keymap.set('n', '<S-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease window width' })
vim.keymap.set('n', '<S-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase window width' })
