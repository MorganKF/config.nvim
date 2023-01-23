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
