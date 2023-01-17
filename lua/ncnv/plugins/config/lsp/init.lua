return {
    {
        'neovim/nvim-lspconfig',
        event = 'BufReadPre',
        dependencies = {
            { 'folke/neoconf.nvim', cmd = 'Neoconf', config = true },
            { 'folke/neodev.nvim', opts = { experimental = { pathStrict = true } } },
            'mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'hrsh7th/cmp-nvim-lsp',
            'jose-elias-alvarez/typescript.nvim',
            'simrat39/rust-tools.nvim',
        },
        opts = {
            diagnostics = {
                underline = true,
                update_in_insert = false,
                virtual_text = { spacing = 4, prefix = '●' },
                severity_sort = true,
            },
            format = {
                formatting_options = nil,
                timeout_ms = nil,
            },
            servers = {
                jsonls = {},
                cssls = {},
                tsserver = {},
                rust_analyzer = {
                    settings = {
                        ['rust-analyzer'] = {
                            cargo = {
                                loadOutDirsFromCheck = true,
                            },
                            procMacro = {
                                enable = true,
                            },
                            checkOnSave = {
                                command = 'clippy',
                            },
                        },
                    },
                },
                sumneko_lua = {
                    settings = {
                        Lua = {
                            workspace = {
                                checkThirdParty = false,
                            },
                            completion = {
                                callSnippet = 'Replace',
                            },
                        },
                    },
                },
            },
            setup = {
                tsserver = function(_, opts)
                    require('typescript').setup({ server = opts })
                    return true
                end,
                rust_analyzer = function(_, opts)
                    require('rust-tools').setup({ server = opts })
                end,
            },
        },
        config = function(_, opts)
            require('ncnv.plugins.util').on_attach(function(client, buffer)
                require('ncnv.plugins.config.lsp.format').on_attach(client, buffer)
                require('ncnv.plugins.config.lsp.bindings').on_attach(client, buffer)
            end)

            vim.diagnostic.config(opts.diagnostics)

            local servers = opts.servers
            local capabilities =
                require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

            require('mason-lspconfig').setup({ ensure_installed = vim.tbl_keys(servers) })
            require('mason-lspconfig').setup_handlers({
                function(server)
                    local server_opts = servers[server] or {}
                    server_opts.capabilities = capabilities
                    if opts.setup[server] then
                        if opts.setup[server](server, server_opts) then
                            return
                        end
                    elseif opts.setup['*'] then
                        if opts.setup['*'](server, server_opts) then
                            return
                        end
                    end
                    require('lspconfig')[server].setup(server_opts)
                end,
            })
        end,
    },

    {
        'jose-elias-alvarez/null-ls.nvim',
        event = 'BufReadPre',
        dependencies = { 'mason.nvim' },
        opts = function()
            local nls = require('null-ls')
            return {
                sources = {
                    nls.builtins.formatting.stylua,
                    nls.builtins.code_actions.gitsigns,
                    nls.builtins.code_actions.eslint_d.with({
                        extra_filetypes = { 'svelte' },
                    }),
                    nls.builtins.diagnostics.eslint_d.with({
                        extra_filetypes = { 'svelte' },
                    }),
                    nls.builtins.formatting.eslint_d.with({
                        extra_filetypes = { 'svelte' },
                    }),
                    nls.builtins.formatting.prettierd.with({
                        extra_filetypes = { 'svelte' },
                    }),
                },
            }
        end,
    },

    {
        'williamboman/mason.nvim',
        cmd = 'Mason',
        keys = { { '<leader>cm', '<cmd>Mason<cr>', desc = 'Mason' } },
        opts = {
            ensure_installed = {
                'stylua',
                'prettierd',
            },
        },

        config = function(_, opts)
            require('mason').setup(opts)
            local mr = require('mason-registry')
            for _, tool in ipairs(opts.ensure_installed) do
                local p = mr.get_package(tool)
                if not p:is_installed() then
                    p:install()
                end
            end
        end,
    },
}
