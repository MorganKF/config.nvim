require('ncnv.plugins.bootstrap')

local present, lazy = pcall(require, 'lazy')

if not present then
    error('Error importing lazy.nvim')
    return false
end

lazy.setup('ncnv.plugins.config')
