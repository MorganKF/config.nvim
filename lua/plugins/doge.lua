return {
    {
        'kkoomen/vim-doge',
        init = function()
            vim.g.doge_enable_mappings = 0
        end,
        build = ':call doge#install()',
        keys = {
            {
                '<leader>rg',
                '<plug>(doge-generate)',
                mode = 'n',
                desc = 'Generate Docs',
            },
        },
    },
}
