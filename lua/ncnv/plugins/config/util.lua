return {
    {
        { 'folke/lazy.nvim', version = false },
    },
    {
        'folke/persistence.nvim',
        event = 'BufReadPre',
        opts = { options = { 'buffers', 'curdir', 'tabpages', 'winsize', 'help' } },
        keys = {
            {
                '<leader>qs',
                function()
                    require('persistence').load()
                end,
                desc = 'Restore Session',
            },
            {
                '<leader>ql',
                function()
                    require('persistence').load({ last = true })
                end,
                desc = 'Restore Last Session',
            },
            {
                '<leader>qd',
                function()
                    require('persistence').stop()
                end,
                desc = "Don't Save Current Session",
            },
        },
    },

    'nvim-lua/plenary.nvim',

    { 'tpope/vim-repeat', event = 'VeryLazy' },
}
