local Util = require('ncnv.plugins.util')

return {
    {
        'nvim-tree/nvim-tree.lua',
        key = {
            vim.keymap.set('n', '<F4>', function()
                local view = require('nvim-tree.view')
                if view.is_visible() then
                    view.close()
                else
                    require('nvim-tree').open_replacing_current_buffer()
                end
            end, { desc = 'Open nvim-tree' }),
        },
        opts = {
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
        },
    },
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
            },
        },
        cmd = 'Telescope',
        version = false,
        keys = {
            { '<leader>,', '<cmd>Telescope buffers show_all_buffers=true<cr>', desc = 'Switch Buffer' },
            { '<leader>/', Util.telescope('live_grep'), desc = 'Find in Files (Grep)' },
            { '<leader>:', '<cmd>Telescope command_history<cr>', desc = 'Command History' },
            { '<leader>ff', Util.telescope('files'), desc = 'Find Files (root dir)' },
            { '<leader>fF', Util.telescope('files', { cwd = false }), desc = 'Find Files (cwd)' },
            { '<leader>fb', '<cmd>Telescope buffers<cr>', desc = 'Buffers' },
            { '<leader>fr', '<cmd>Telescope oldfiles<cr>', desc = 'Recent' },
            { '<leader>gc', '<cmd>Telescope git_commits<CR>', desc = 'commits' },
            { '<leader>gs', '<cmd>Telescope git_status<CR>', desc = 'status' },
            { '<leader>sC', '<cmd>Telescope commands<cr>', desc = 'Commands' },
            { '<leader>sG', Util.telescope('live_grep', { cwd = false }), desc = 'Grep (cwd)' },
            { '<leader>sM', '<cmd>Telescope man_pages<cr>', desc = 'Man Pages' },
            { '<leader>sa', '<cmd>Telescope autocommands<cr>', desc = 'Auto Commands' },
            { '<leader>sb', '<cmd>Telescope current_buffer_fuzzy_find<cr>', desc = 'Buffer' },
            { '<leader>sc', '<cmd>Telescope command_history<cr>', desc = 'Command History' },
            { '<leader>sg', Util.telescope('live_grep'), desc = 'Grep (root dir)' },
            { '<leader>sh', '<cmd>Telescope help_tags<cr>', desc = 'Help Pages' },
            { '<leader>sH', '<cmd>Telescope highlights<cr>', desc = 'Search Highlight Groups' },
            { '<leader>sk', '<cmd>Telescope keymaps<cr>', desc = 'Key Maps' },
            { '<leader>sm', '<cmd>Telescope marks<cr>', desc = 'Jump to Mark' },
            { '<leader>so', '<cmd>Telescope vim_options<cr>', desc = 'Options' },
            { '<leader>st', '<cmd>Telescope builtin<cr>', desc = 'Telescope' },
            {
                '<leader>ss',
                Util.telescope('lsp_document_symbols', {
                    symbols = {
                        'Class',
                        'Function',
                        'Method',
                        'Constructor',
                        'Interface',
                        'Module',
                        'Struct',
                        'Trait',
                        'Field',
                        'Property',
                    },
                }),
                desc = 'Goto Symbol',
            },
        },
        opts = {
            defaults = {
                prompt_prefix = ' ',
                selection_caret = ' ',
                file_ignore_patterns = {
                    'node_modules',
                    '.git',
                    '.cache',
                    '%.o',
                    '%.a',
                    '%.dll',
                    '%.so',
                    '%.dylib',
                    '%.png',
                    'target',
                },
                vimgrep_arguments = {
                    'rg',
                    '--hidden',
                    '--color=never',
                    '--no-heading',
                    '--with-filename',
                    '--line-number',
                    '--column',
                    '--smart-case',
                },
                sorting_strategy = 'ascending',
                layout_strategy = 'horizontal',
                layout_config = {
                    horizontal = {
                        prompt_position = 'top',
                        preview_width = 0.55,
                        results_width = 0.8,
                    },
                    vertical = {
                        mirror = false,
                    },
                    width = 0.87,
                    height = 0.80,
                    preview_cutoff = 120,
                },
                winblend = 0,
            },
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = 'smart_case',
                },
            },
        },
    },
    {
        'lewis6991/gitsigns.nvim',
        event = 'BufReadPre',
        opts = {
            signs = {
                add = { text = '▎' },
                change = { text = '▎' },
                delete = { text = '契' },
                topdelete = { text = '契' },
                changedelete = { text = '▎' },
                untracked = { text = '▎' },
            },
            on_attach = function(buffer)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, desc)
                    vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
                end

                map('n', ']h', gs.next_hunk, 'Next Hunk')
                map('n', '[h', gs.prev_hunk, 'Prev Hunk')
                map({ 'n', 'v' }, '<leader>ghs', ':Gitsigns stage_hunk<CR>', 'Stage Hunk')
                map({ 'n', 'v' }, '<leader>ghr', ':Gitsigns reset_hunk<CR>', 'Reset Hunk')
                map('n', '<leader>ghS', gs.stage_buffer, 'Stage Buffer')
                map('n', '<leader>ghu', gs.undo_stage_hunk, 'Undo Stage Hunk')
                map('n', '<leader>ghR', gs.reset_buffer, 'Reset Buffer')
                map('n', '<leader>ghp', gs.preview_hunk, 'Preview Hunk')
                map('n', '<leader>ghb', function()
                    gs.blame_line({ full = true })
                end, 'Blame Line')
                map('n', '<leader>ghd', gs.diffthis, 'Diff This')
                map('n', '<leader>ghD', function()
                    gs.diffthis('~')
                end, 'Diff This ~')
                map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', 'GitSigns Select Hunk')
            end,
        },
    },
    {
        'echasnovski/mini.bufremove',
        keys = {
            {
                'kb',
                function()
                    require('mini.bufremove').delete(0, false)
                end,
                desc = 'Delete Buffer',
            },
            {
                'kB',
                function()
                    require('mini.bufremove').delete(0, true)
                end,
                desc = 'Delete Buffer (Force)',
            },
        },
    },
    {
        'folke/trouble.nvim',
        cmd = { 'TroubleToggle', 'Trouble' },
        opts = { use_diagnostic_signs = true },
        keys = {
            { '<leader>xx', '<cmd>TroubleToggle document_diagnostics<cr>', desc = 'Document Diagnostics (Trouble)' },
            { '<leader>xX', '<cmd>TroubleToggle workspace_diagnostics<cr>', desc = 'Workspace Diagnostics (Trouble)' },
        },
    },
    {
        'folke/todo-comments.nvim',
        cmd = { 'TodoTrouble', 'TodoTelescope' },
        event = 'BufReadPost',
        config = true,
        keys = {
            {
                ']t',
                function()
                    require('todo-comments').jump_next()
                end,
                desc = 'Next todo comment',
            },
            {
                '[t',
                function()
                    require('todo-comments').jump_prev()
                end,
                desc = 'Previous todo comment',
            },
            { '<leader>xt', '<cmd>TodoTrouble<cr>', desc = 'Todo Trouble' },
            { '<leader>xtt', '<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>', desc = 'Todo Trouble' },
            { '<leader>xT', '<cmd>TodoTelescope<cr>', desc = 'Todo Telescope' },
        },
    },
    {
        'ggandor/leap.nvim',
        event = 'VeryLazy',
        dependencies = { { 'ggandor/flit.nvim', opts = { labeled_modes = 'nv' } } },
        config = function(_, opts)
            local leap = require('leap')
            for k, v in pairs(opts) do
                leap.opts[k] = v
            end
            leap.add_default_mappings(true)
        end,
    },
    {
        'folke/which-key.nvim',
        event = 'VeryLazy',
        opts = {
            plugins = { spelling = true },
            key_labels = { ['<leader>'] = ',' },
        },
        config = function(_, opts)
            local wk = require('which-key')
            wk.setup(opts)
            wk.register({
                mode = { 'n', 'v' },
                ['g'] = { name = '+goto' },
                [']'] = { name = '+next' },
                ['['] = { name = '+prev' },
                ['<leader><tab>'] = { name = '+tabs' },
                ['<leader>b'] = { name = '+buffer' },
                ['<leader>c'] = { name = '+code' },
                ['<leader>f'] = { name = '+file/find' },
                ['<leader>g'] = { name = '+git' },
                ['<leader>gh'] = { name = '+hunks' },
                ['<leader>q'] = { name = '+quit/session' },
                ['<leader>s'] = { name = '+search' },
                ['<leader>sn'] = { name = '+noice' },
                ['<leader>u'] = { name = '+ui' },
                ['<leader>w'] = { name = '+windows' },
                ['<leader>x'] = { name = '+diagnostics/quickfix' },
            })
        end,
    },
}
