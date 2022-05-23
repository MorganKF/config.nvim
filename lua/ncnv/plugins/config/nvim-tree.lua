local present, nvim_tree = pcall(require, 'nvim-tree')

if not present then
    return
end

nvim_tree.setup({
    hijack_netrw = true,
    hijack_directories = {
        enable = true,
        auto_open = true,
    },
    view = {
        mappings = {
            list = {
                { key = '<CR>', action = 'edit_in_place' },
            },
        },
    },
})

ncnv.toggle_nvim_tree_inplace = function()
    local view = require('nvim-tree.view')
    if view.is_visible() then
        view.close()
    else
        nvim_tree.open_replacing_current_buffer()
    end
end

vim.keymap.set('n', '<F4>', ncnv.toggle_nvim_tree_inplace, {})
