local present, lspconfig = pcall(require, 'lspconfig')

if not present then
    return
end

require('mason').setup()
require('mason-lspconfig').setup()
require('luasnip.loaders.from_vscode').lazy_load()

vim.opt.completeopt = 'menuone,noselect'

local cmp = require('cmp')
local luasnip = require('luasnip')
local lspkind = require('lspkind')
local servers = {
    'sumneko_lua',
    'rust_analyzer',
    'tsserver',
    'jsonls',
    'cssls',
    'jedi_language_server',
    'clangd',
    'svelte',
    'tailwindcss',
}

local on_attach = function(_, bufnr)
    local opts = { buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wl', function()
        vim.inspect(vim.lsp.buf.list_workspace_folders())
    end, opts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>so', require('telescope.builtin').lsp_document_symbols, opts)
    vim.api.nvim_create_user_command('Format', vim.lsp.buf.formatting, {})
end

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem = {
    documentationFormat = { 'markdown', 'plaintext' },
    snippetSupport = true,
    preselectSupport = true,
    insertReplaceSupport = true,
    labelDetailsSupport = true,
    deprecatedSupport = true,
    commitCharactersSupport = true,
    resolveSupport = {
        properties = {
            'documentation',
            'detail',
            'additionalTextEdits',
        },
    },
}

for _, lsp in ipairs(servers) do
    if lsp == 'tsserver' then
        require('typescript').setup({
            server = {
                capabilities = capabilities,
                on_attach = on_attach,
            },
        })
    elseif lsp == 'rust_analyzer' then
        require('rust-tools').setup({
            server = {
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                    ['rust-analyzer'] = {
                        cargo = {
                            loadOutDirsFromCheck = true,
                        },
                        procMacro = {
                            enable = true,
                        },
                        checkOnSave = {
                            command = 'clippy',
                        },
                    },
                },
            },
        })
    else
        lspconfig[lsp].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })
    end
end

cmp.setup({
    window = {
        completion = {
            border = 'rounded',
        },
        documentation = {
            border = 'rounded',
        },
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    formatting = {
        format = lspkind.cmp_format(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-t>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete({}),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
    },
})

vim.api.nvim_create_autocmd('InsertLeave', {
    callback = function()
        if luasnip.session.current_nodes[vim.api.nvim_get_current_buf()] and not luasnip.session.jump_active then
            luasnip.unlink_current()
        end
    end,
    group = ncnv.augroup,
})

---@diagnostic disable-next-line: redefined-local
local present, cmp_autopairs = pcall(require, 'nvim-autopairs.completion.cmp')

if present then
    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))
end
