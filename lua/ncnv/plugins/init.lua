local present, packer = pcall(require, 'ncnv.plugins.packerinit')

if not present then
    error(packer)
    return false
end

packer.startup(function(use)
    -- Lua library
    use({ 'nvim-lua/plenary.nvim' })

    -- Benchmarks and caching
    use({ 'lewis6991/impatient.nvim' })

    -- Keeps packer updated
    use({ 'wbthomason/packer.nvim' })

    --------
    -- UI --
    --------

    -- Font icons
    use({ 'kyazdani42/nvim-web-devicons' })

    -- GitHub theme
    use({
        'projekt0n/github-nvim-theme',
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

    -- Fuzy finding, grep, and file browser
    use({
        'nvim-telescope/telescope.nvim',
        config = function()
            require('ncnv.plugins.config.telescope')
        end,
    })
    use({
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make',
        requires = { 'nvim-telescope/telescope.nvim' },
    })

    -- Draws indent lines
    use({ 'lukas-reineke/indent-blankline.nvim' })

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

    ---------
    -- LSP --
    ---------

    ------------------------
    -- Syntax / Languange --
    ------------------------

    -- Better syntax highlighting
    use({
        'nvim-treesitter/nvim-treesitter',
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

    -- Generate comments
    use({
        'numToStr/Comment.nvim',
        config = function()
            require('ncnv.plugins.config.comment')
        end,
    })

    -- More motions
    use({
        'phaazon/hop.nvim',
        config = function()
            require('ncnv.plugins.config.hop')
        end,
    })
end)
