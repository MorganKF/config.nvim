return {
    {
        'rcarriga/nvim-notify',
        keys = {
            {
                '<leader>un',
                function()
                    require('notify').dismiss({ silent = true, pending = true })
                end,
                desc = 'Delete all Notifications',
            },
        },
        opts = {
            timeout = 3000,
            max_height = function()
                return math.floor(vim.o.lines * 0.75)
            end,
            max_width = function()
                return math.floor(vim.o.columns * 0.75)
            end,
        },
    },
    {
        'stevearc/dressing.nvim',
        init = function()
            vim.ui.select = function(...)
                require('lazy').load({ plugins = { 'dressing.nvim' } })
                return vim.ui.select(...)
            end
            vim.ui.input = function(...)
                require('lazy').load({ plugins = { 'dressing.nvim' } })
                return vim.ui.input(...)
            end
        end,
    },
    {
        'akinsho/nvim-bufferline.lua',
        event = 'VeryLazy',
        init = function()
            vim.keymap.set('n', '<tab>', '<cmd>BufferLineCycleNext<CR>', { desc = 'Next buffer' })
            vim.keymap.set('n', '<S-tab>', '<cmd>BufferLineCyclePrev<CR>', { desc = 'Previous buffer' })
        end,
        opts = {
            options = {
                diagnostics = 'nvim_lsp',
                always_show_bufferline = false,
                show_close_icon = false,
                show_buffer_close_icons = false,
            },
        },
    },
    {
        'nvim-lualine/lualine.nvim',
        event = 'VeryLazy',
        opts = function()
            local function fg(name)
                return function()
                    local hl = vim.api.nvim_get_hl_by_name(name, true)
                    return hl and hl.foreground and { fg = string.format('#%06x', hl.foreground) }
                end
            end

            return {
                options = {
                    globalstatus = true,
                    disabled_filetypes = { statusline = { 'dashboard', 'lazy', 'alpha' } },
                    icons_enabled = true,
                    theme = 'github_dimmed',
                    component_separators = { left = '', right = '' },
                    section_separators = { left = '', right = '' },
                    always_divide_middle = true,
                },
                sections = {
                    lualine_a = { 'mode' },
                    lualine_b = { 'branch' },
                    lualine_c = {
                        {
                            'diagnostics',
                        },
                        { 'filetype', icon_only = true, separator = '', padding = { left = 1, right = 0 } },
                        { 'filename' },
                    },
                    lualine_x = {
                        {
                            function()
                                return require('noice').api.status.command.get()
                            end,
                            cond = function()
                                return package.loaded['noice'] and require('noice').api.status.command.has()
                            end,
                            color = fg('Statement'),
                        },
                        {
                            function()
                                return require('noice').api.status.mode.get()
                            end,
                            cond = function()
                                return package.loaded['noice'] and require('noice').api.status.mode.has()
                            end,
                            color = fg('Constant'),
                        },
                        {
                            require('lazy.status').updates,
                            cond = require('lazy.status').has_updates,
                            color = fg('Special'),
                        },
                        {
                            'diff',
                        },
                    },
                    lualine_y = { 'progress' },
                    lualine_z = { 'location' },
                },
                extensions = { 'nvim-tree' },
            }
        end,
    },
    {
        'lukas-reineke/indent-blankline.nvim',
        event = 'BufReadPre',
        opts = {
            char = '│',
            filetype_exclude = { 'help', 'alpha', 'dashboard', 'nvim-tree', 'Trouble', 'lazy' },
            show_trailing_blankline_indent = false,
            show_current_context = false,
        },
    },
    {
        'echasnovski/mini.indentscope',
        event = 'BufReadPre',
        opts = {
            symbol = '│',
            options = { try_as_border = true },
            draw = { delay = 50 },
        },
        config = function(_, opts)
            vim.api.nvim_create_autocmd('FileType', {
                pattern = { 'help', 'alpha', 'dashboard', 'nvim-tree', 'Trouble', 'lazy', 'mason' },
                callback = function()
                    vim.b.miniindentscope_disable = true
                end,
            })
            require('mini.indentscope').setup(opts)
        end,
    },
    {
        'folke/noice.nvim',
        event = 'VeryLazy',
        opts = {
            lsp = {
                override = {
                    ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
                    ['vim.lsp.util.stylize_markdown'] = true,
                },
            },
            presets = {
                bottom_search = true,
                command_palette = true,
                long_message_to_split = true,
                lsp_doc_border = true,
            },
        },
    },
    {
        'projekt0n/github-nvim-theme',
        opts = {
            theme_style = 'dark_default',
            dark_float = true,
        },
        config = function(_, opts)
            require('github-theme').setup(opts)
        end,
    },
    { 'nvim-tree/nvim-web-devicons' },
    { 'MunifTanjim/nui.nvim' },
}
