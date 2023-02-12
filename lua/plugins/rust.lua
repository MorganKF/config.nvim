return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = function(_, opts)
            table.insert(opts.ensure_installed, 'rust')
        end,
    },

    {
        {
            'neovim/nvim-lspconfig',
            dependencies = { 'simrat39/rust-tools.nvim' },
            opts = {
                servers = {
                    rust_analyzer = {
                        settings = {
                            ['rust-analyzer'] = {
                                cargo = {
                                    allFeatures = true,
                                },
                                checkOnSave = {
                                    allFeatures = true,
                                    command = 'clippy',
                                    extraArgs = { '--no-deps' },
                                },
                                procMacro = {
                                    ignored = {
                                        ['async-trait'] = { 'async_trait' },
                                        ['napi-derive'] = { 'napi' },
                                        ['async-recursion'] = { 'async_recursion' },
                                    },
                                },
                            },
                        },
                    },
                },
                setup = {
                    rust_analyzer = function(_, opts)
                        require('lazyvim.util').on_attach(function(client, buffer)
                            if client.name == 'rust_analyzer' then
                                vim.keymap.set(
                                    'n',
                                    '<leader>co',
                                    'RustHoverActions',
                                    { buffer = buffer, desc = 'Hover Actions (Rust)' }
                                )
                                vim.keymap.set(
                                    'n',
                                    '<leader>cR',
                                    'RustCodeActionGroup',
                                    { buffer = buffer, desc = 'Code Action (Rust)' }
                                )
                            end
                        end)
                        local rust_opts = {
                            server = vim.tbl_deep_extend('force', {}, opts, opts.server or {}),
                            tools = {
                                hover_actions = {
                                    auto_focus = true,
                                },
                            },
                        }
                        require('rust-tools').setup(rust_opts)
                        return true
                    end,
                },
            },
        },
    },

    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            {
                'Saecki/crates.nvim',
                event = { 'BufRead Cargo.toml' },
                config = true,
            },
        },
        opts = function(_, opts)
            local cmp = require('cmp')
            opts.sources = cmp.config.sources(vim.list_extend(opts.sources, {
                { name = 'crates' },
            }))
        end,
    },
}
