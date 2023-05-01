return {
    {
        'folke/which-key.nvim',
        opts = {
            defaults = {
                ['<leader>r'] = { name = '+refactor' },
            },
        },
    },
    {
        'ThePrimeagen/refactoring.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-treesitter/nvim-treesitter',
        },
        keys = {
            {
                '<leader>rf',
                function()
                    require('refactoring').refactor('Extract Function')
                end,
                mode = 'v',
                desc = 'Extract Function',
            },
            {
                '<leader>rF',
                function()
                    require('refactoring').refactor('Extract Function To File')
                end,
                mode = 'v',
                desc = 'Extract function to file',
            },
            {
                '<leader>rv',
                function()
                    require('refactoring').refactor('Extract Variable')
                end,
                mode = 'v',
                desc = 'Extract variable',
            },
            {
                '<leader>ri',
                function()
                    require('refactoring').refactor('Inline variable')
                end,
                mode = 'v',
                desc = 'Inline variable',
            },
            {
                '<leader>rb',
                function()
                    require('refactoring').refactor('Extract Block')
                end,
                mode = 'n',
                desc = 'Extract block',
            },
            {
                '<leader>rB',
                function()
                    require('refactoring').refactor('Extract Block To File')
                end,
                mode = 'n',
                desc = 'Extract block to file',
            },
            {
                '<leader>ri',
                function()
                    require('refactoring').refactor('Inline variable')
                end,
                mode = 'n',
                desc = 'Inline variable',
            },
        },
    },
}
