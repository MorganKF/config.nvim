vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- Emulate windows copy and cut
vim.keymap.set('v', '<C-c>', '"+y<CR>', { noremap = true })
vim.keymap.set('v', '<C-x>', '"+d<CR>', { noremap = true })

-- Disable hl with two esc
vim.keymap.set('', '<esc><esc>', '<cmd>noh<CR><esc>', { noremap = true, silent = true })

-- Buffer navigation
vim.keymap.set('n', '<tab>', '<cmd>BufferLineCycleNext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<S-tab>', '<cmd>BufferLineCyclePrev<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'kb', '<cmd>pdelete<CR>', { noremap = true, silent = true })
