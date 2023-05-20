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

-- Fix luasnip session remaining after exiting insert mode
vim.api.nvim_create_autocmd('ModeChanged', {
    pattern = '*',
    callback = function()
        if
            ((vim.v.event.old_mode == 's' and vim.v.event.new_mode == 'n') or vim.v.event.old_mode == 'i')
            and require('luasnip').session.current_nodes[vim.api.nvim_get_current_buf()]
            and not require('luasnip').session.jump_active
        then
            require('luasnip').unlink_current()
        end
    end,
})
