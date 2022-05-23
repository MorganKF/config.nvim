local present, _ = pcall(require, 'mini.surround')

if not present then
    return
end

require('mini.surround').setup({})
