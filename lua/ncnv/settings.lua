-- Text options
vim.opt.encoding = 'utf-8'
vim.opt.wrap = false
vim.opt.hlsearch = true
vim.opt.number = true
vim.cmd('syntax enable')

-- Allow scrolling with scroll wheel
vim.opt.mouse = 'a'

-- Tabs
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- History
vim.opt.history = 1000
vim.opt.undofile = true
vim.opt.scrolljump = 5
vim.opt.updatetime = 300
vim.opt.writebackup = false
vim.cmd('filetype plugin indent on')

-- UI
vim.opt.termguicolors = true

-- Return to last edit position
vim.api.nvim_create_autocmd('BufReadPost', {
    callback = function()
        if vim.fn.line('\'"') > 0 and vim.fn.line('\'"') <= vim.fn.line('$') then
            vim.cmd('normal! g`"')
        end
    end,
    group = ncnv.augroup,
})
