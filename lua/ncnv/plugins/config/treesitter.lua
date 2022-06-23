local present, treesitter = pcall(require, 'nvim-treesitter.configs')

if not present then
    return
end

treesitter.setup({
    ensure_installed = { 'javascript', 'typescript', 'tsx', 'lua', 'rust', 'cpp', 'c', 'css', 'json', 'python' },
    highlight = {
        enable = true,
    },
})
