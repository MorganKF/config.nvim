local present, treesitter = pcall(require, 'nvim-treesitter.configs')

if not present then
    return
end

treesitter.setup({
    ensure_installed = { 'javascript', 'typescript', 'tsx', 'lua', 'rust' },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
})
