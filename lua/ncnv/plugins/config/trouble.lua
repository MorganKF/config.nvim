local present, trouble = pcall(require, 'trouble')

if not present then
    return
end

trouble.setup({})

local opts = { silent = true }
vim.keymap.set('n', '<leader>tt', '<cmd>Trouble<cr>', opts)
vim.keymap.set('n', '<leader>tw', '<cmd>Trouble workspace_diagnostics<cr>', opts)
vim.keymap.set('n', '<leader>td', '<cmd>Trouble document_diagnostics<cr>', opts)
vim.keymap.set('n', '<leader>tf', '<cmd>Trouble quickfix<cr>', opts)
