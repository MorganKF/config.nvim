local present, packer = pcall(require, 'ncnv.plugins.packerinit')

if not present then
    error(packer)
    return false
end

function configure(path, setup)
    local present, plug = pcall(require, path)

    if not present then
        return
    end

    plug.setup(setup)
end

packer.startup(function(use)
    -- Lua function library
    use({ 'nvim-lua/plenary.nvim' })

    -- Benchmarks and caching
    use({ 'lewis6991/impatient.nvim' })

    -- Keeps packer updated
    use({
        'wbthomason/packer.nvim',
        event = 'VimEnter',
    })

    --------
    -- UI --
    --------

    -- Font icons
    use({ 'kyazdani42/nvim-web-devicons' })

    -- GitHub theme
    use({
        'projekt0n/github-nvim-theme',
        config = function()
            configure('github-theme', {
                theme_style = 'dark_default',
                dark_float = true,
            })
        end,
    })

    -- Buffer & tabline
    use({
        'akinsho/bufferline.nvim',
        tag = 'v2.*',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = function()
            require('ncnv.plugins.config.bufferline')
        end,
    })

    -- Git status & actions
    use({
        'lewis6991/gitsigns.nvim',
        config = function()
            configure('gitsigns', {})
        end,
    })

    -- Prompt w/ native fzf
    use({
        'nvim-telescope/telescope.nvim',
        config = function()
            require('ncnv.plugins.config.telescope')
        end,
    })

    use({
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make',
        requires = 'nvim-telescope/telescope.nvim',
    })

    -- Draws indent lines
    use({
        'lukas-reineke/indent-blankline.nvim',
        event = 'BufRead',
        config = function()
            configure('indent_blankline', {})
        end,
    })

    -- Fast statusline
    use({
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = function()
            require('ncnv.plugins.config.lualine')
        end,
    })

    -- Filebrowser
    use({
        'kyazdani42/nvim-tree.lua',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = function()
            require('ncnv.plugins.config.nvim-tree')
        end,
        tag = 'nightly',
    })

    -- Improve nvim select and input UI
    use({
        'stevearc/dressing.nvim',
        config = function()
            configure('dressing', {})
        end,
    })

    ---------
    -- LSP --
    ---------

    use({
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'onsails/lspkind.nvim',
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'saadparwaiz1/cmp_luasnip',
        'folke/neodev.nvim',
        'jose-elias-alvarez/typescript.nvim',
        'simrat39/rust-tools.nvim',
        'rafamadriz/friendly-snippets',
        'L3MON4D3/LuaSnip',
        {
            'neovim/nvim-lspconfig',
            config = function()
                configure('neodev', {})
                require('ncnv.plugins.config.lspconfig')
            end,
        },
    })

    use({
        'jose-elias-alvarez/null-ls.nvim',
        requires = 'nvim-lua/plenary.nvim',
        wants = 'lewis6991/gitsigns.nvim',
        config = function()
            require('ncnv.plugins.config.null-ls')
        end,
    })

    use({
        'folke/trouble.nvim',
        event = { 'BufRead', 'BufNewFile' },
        config = function()
            require('ncnv.plugins.config.trouble')
        end,
    })

    ------------------------
    -- Syntax / Languange --
    ------------------------

    -- Better syntax highlighting
    use({
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
            require('ncnv.plugins.config.treesitter')
        end,
    })

    -------------
    -- Utility --
    -------------

    -- Surround replacement & extras
    use({
        'echasnovski/mini.nvim',
        branch = 'stable',
        config = function()
            require('ncnv.plugins.config.mini')
        end,
    })

    --Auto close pairs
    use({
        'windwp/nvim-autopairs',
        config = function()
            configure('nvim-autopairs', {})
        end,
    })
    use({
        'windwp/nvim-ts-autotag',
        config = function()
            configure('nvim-ts-autotag', {})
        end,
    })

    -- More motions
    use({
        'phaazon/hop.nvim',
        config = function()
            require('ncnv.plugins.config.hop')
        end,
    })

    -- Detect file settings
    use({ 'tpope/vim-sleuth' })

    -- Highlight and search todo comments
    use({
        'folke/todo-comments.nvim',
        requires = 'nvim-lua/plenary.nvim',
        config = function()
            configure('todo-comments', {})
        end,
    })
end)
