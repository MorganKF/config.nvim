local opts = { noremap = true, silent = true }

vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- better up/down
vim.keymap.set('n', '<down>', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set('n', '<up>', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Emulate windows copy and cut
vim.keymap.set('v', '<C-c>', '"+y<CR>', opts)
vim.keymap.set('v', '<C-x>', '"+d<CR>', opts)

-- Disable hl with esc
vim.keymap.set('n', '<esc>', '<cmd>noh<CR><CR>', opts)

-- Split navigation
vim.keymap.set('n', '<C-up>', '<C-w><up>', opts)
vim.keymap.set('n', '<C-down>', '<C-w><down>', opts)
vim.keymap.set('n', '<C-right>', '<C-w><right>', opts)
vim.keymap.set('n', '<C-left>', '<C-w><left>', opts)

-- Resize window using <ctrl> arrow keys
vim.keymap.set('n', '<S-Up>', '<cmd>resize +2<cr>', { desc = 'Increase window height' })
vim.keymap.set('n', '<S-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease window height' })
vim.keymap.set('n', '<S-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease window width' })
vim.keymap.set('n', '<S-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase window width' })

vim.keymap.set('n', 'gw', '*N')
vim.keymap.set('x', 'gw', '*N')

-- Sane N
vim.keymap.set('n', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next search result' })
vim.keymap.set('x', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next search result' })
vim.keymap.set('o', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next search result' })
vim.keymap.set('n', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev search result' })
vim.keymap.set('x', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev search result' })
vim.keymap.set('o', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev search result' })

-- new file
vim.keymap.set('n', '<leader>fn', '<cmd>enew<cr>', { desc = 'New File' })

-- save file
vim.keymap.set({ 'i', 'v', 'n', 's' }, '<C-s>', '<cmd>w<cr><esc>', { desc = 'Save file' })

-- better indenting
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

vim.keymap.set('n', '<leader>xl', '<cmd>lopen<cr>', { desc = 'Open Location List' })
vim.keymap.set('n', '<leader>xq', '<cmd>copen<cr>', { desc = 'Open Quickfix List' })

-- Close quickfix windows
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'qf',
    callback = function()
        vim.keymap.set('n', '<CR>', '<CR><CMD>cclose<CR>', {
            silent = true,
            buffer = 0,
        })
    end,
})
