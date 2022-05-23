-- Text options
vim.opt.encoding = 'utf-8'
vim.opt.wrap = false
vim.opt.hlsearch = true
vim.opt.number = true

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
vim.opt.signcolumn = 'yes'
vim.opt.shortmess = vim.o.shortmess .. 'c'
vim.opt.backup = false
vim.opt.writebackup = false
vim.cmd('filetype plugin indent on')

-- UI
vim.opt.termguicolors = true
vim.cmd('colorscheme github_dark_default')
