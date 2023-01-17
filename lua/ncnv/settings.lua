-- Text options
vim.opt.encoding = 'utf-8'
vim.opt.wrap = false
vim.opt.hlsearch = true
vim.opt.number = true
vim.cmd('syntax enable')

-- Enable mouse support where available
vim.opt.mouse = 'a'

-- Tabs
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.shiftround = true
vim.opt.expandtab = true

-- History
vim.opt.history = 1000
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.scrolljump = 5
vim.opt.updatetime = 300
vim.opt.writebackup = false
vim.cmd('filetype plugin indent on')

-- UI
vim.opt.termguicolors = true
vim.opt.showmode = false
vim.opt.signcolumn = 'yes'

vim.opt.grepprg = 'rg --vimgrep'
vim.opt.completeopt = 'menu,menuone,noselect'
vim.opt.wildmode = 'longest:full,full'
vim.opt.sessionoptions = { 'buffers', 'curdir', 'tabpages', 'winsize' }

if vim.fn.has('nvim-0.9.0') == 1 then
    vim.opt.splitkeep = 'screen'
    vim.opt.shortmess = 'filnxtToOFWIcC'
end

vim.g.markdown_recommended_style = 0
