return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        event = 'BufReadPost',
        opts = {
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true },
            context_commentstring = { enable = true, enable_autocmd = false },
            ensure_installed = {
                'bash',
                'help',
                'html',
                'javascript',
                'typescript',
                'tsx',
                'rust',
                'c',
                'css',
                'json',
                'lua',
                'markdown',
                'markdown_inline',
                'python',
                'query',
                'regex',
                'vim',
                'yaml',
            },
        },
        config = function(_, opts)
            require('nvim-treesitter.configs').setup(opts)
        end,
    },
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'saadparwaiz1/cmp_luasnip',
            'onsails/lspkind.nvim',
            'L3MON4D3/LuaSnip',
        },
        opts = function()
            local cmp = require('cmp')
            return {
                completion = {
                    completeopt = 'menu,menuone,noinsert',
                },
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-t>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-d>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    }),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'buffer' },
                    { name = 'path' },
                }),
                formatting = {
                    format = require('lspkind').cmp_format(),
                },
                experimental = {
                    ghost_text = {
                        hl_group = 'LspCodeLens',
                    },
                },
            }
        end,
    },
    {
        'L3MON4D3/LuaSnip',
        dependencies = {
            'rafamadriz/friendly-snippets',
            config = function()
                require('luasnip.loaders.from_vscode').lazy_load()
            end,
        },
        opts = {
            history = true,
            delete_check_events = 'TextChanged',
        },
        keys = {
            {
                '<tab>',
                function()
                    return require('luasnip').jumpable(1) and '<Plug>luasnip-jump-next' or '<tab>'
                end,
                expr = true,
                silent = true,
                mode = 'i',
            },
            {
                '<tab>',
                function()
                    require('luasnip').jump(1)
                end,
                mode = 's',
            },
            {
                '<s-tab>',
                function()
                    require('luasnip').jump(-1)
                end,
                mode = { 'i', 's' },
            },
        },
    },
    {
        'echasnovski/mini.pairs',
        event = 'VeryLazy',
        config = function(_, opts)
            require('mini.pairs').setup(opts)
        end,
    },
    {
        'echasnovski/mini.surround',
        keys = { 'gz' },
        opts = {
            mappings = {
                add = 'gza', -- Add surrounding in Normal and Visual modes
                delete = 'gzd', -- Delete surrounding
                find = 'gzf', -- Find surrounding (to the right)
                find_left = 'gzF', -- Find surrounding (to the left)
                highlight = 'gzh', -- Highlight surrounding
                replace = 'gzr', -- Replace surrounding
                update_n_lines = 'gzn', -- Update `n_lines`
            },
        },
        config = function(_, opts)
            require('mini.surround').setup(opts)
        end,
    },
    { 'JoosepAlviste/nvim-ts-context-commentstring' },
    {
        'echasnovski/mini.comment',
        event = 'VeryLazy',
        opts = {
            hooks = {
                pre = function()
                    require('ts_context_commentstring.internal').update_commentstring({})
                end,
            },
        },
        config = function(_, opts)
            require('mini.comment').setup(opts)
        end,
    },
    {
        'echasnovski/mini.ai',
        keys = {
            { 'a', mode = { 'x', 'o' } },
            { 'i', mode = { 'x', 'o' } },
        },
        dependencies = {
            {
                'nvim-treesitter/nvim-treesitter-textobjects',
                init = function()
                    require('lazy.core.loader').disable_rtp_plugin('nvim-treesitter-textobjects')
                end,
            },
        },
        opts = function()
            local ai = require('mini.ai')
            return {
                n_lines = 500,
                custom_textobjects = {
                    o = ai.gen_spec.treesitter({
                        a = { '@block.outer', '@conditional.outer', '@loop.outer' },
                        i = { '@block.inner', '@conditional.inner', '@loop.inner' },
                    }, {}),
                    f = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }, {}),
                    c = ai.gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' }, {}),
                },
            }
        end,
        config = function(_, opts)
            local ai = require('mini.ai')
            ai.setup(opts)
        end,
    },
    {
        'RRethy/vim-illuminate',
        event = 'BufReadPost',
        opts = { delay = 200 },
        config = function(_, opts)
            require('illuminate').configure(opts)
        end,
        keys = {
            {
                ']]',
                function()
                    require('illuminate').goto_next_reference(false)
                end,
                desc = 'Next Reference',
            },
            {
                '[[',
                function()
                    require('illuminate').goto_prev_reference(false)
                end,
                desc = 'Prev Reference',
            },
        },
    },
    'windwp/nvim-ts-autotag',
    'tpope/vim-sleuth',
}
