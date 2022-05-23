local present, impatient = pcall(require, 'impatient')

if present then
    impatient.enable_profile()
end

require('ncnv.plugins')
require('ncnv.settings')
require('ncnv.mappings')
