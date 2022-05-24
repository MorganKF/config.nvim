vim.g.mapleader = ','
vim.g.maplocalleader = ','

local opts = {noremap = true, silent = true}

-- Emulate windows copy and cut
vim.keymap.set('v', '<C-c>', '"+y<CR>', opts)
vim.keymap.set('v', '<C-x>', '"+d<CR>', opts)

-- Disable hl with two esc
vim.keymap.set('n', '<esc>', '<cmd>noh<CR><CR>', opts)

-- Buffer navigation
vim.keymap.set('n', '<tab>', '<cmd>BufferLineCycleNext<CR>', opts)
vim.keymap.set('n', '<S-tab>', '<cmd>BufferLineCyclePrev<CR>', opts)
vim.keymap.set('n', 'kb', '<cmd>bdelete<CR>', opts)

-- Split navigation
vim.keymap.set('n', '<C-up>', '<C-w><up>', opts)
vim.keymap.set('n', '<C-down>', '<C-w><down>', opts)
vim.keymap.set('n', '<C-right>', '<C-w><right>', opts)
vim.keymap.set('n', '<C-left>', '<C-w><left>', opts)
