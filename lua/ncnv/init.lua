local present, impatient = pcall(require, 'impatient')

if present then
    impatient.enable_profile()
end

-- NCNV global namespace
_G.ncnv = {
    augroup = vim.api.nvim_create_augroup('NCNV', { clear = true }),
}

require('ncnv.plugins')
require('ncnv.settings')
require('ncnv.mappings')
