return {
    {
        'jose-elias-alvarez/null-ls.nvim',
        event = 'BufReadPre',
        dependencies = { 'mason.nvim' },
        opts = function()
            local nls = require('null-ls')
            return {
                sources = {
                    nls.builtins.formatting.prettierd,
                    nls.builtins.formatting.eslint_d,
                    nls.builtins.formatting.stylua,
                    nls.builtins.diagnostics.flake8,
                    nls.builtins.diagnostics.eslint_d,
                    nls.builtins.code_actions.eslint_d,
                },
            }
        end,
    },
}
