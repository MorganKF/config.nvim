local eslint_d_config = {
    condition = function(utils)
        return utils.root_has_file({
            '.eslintrc.js',
            '.eslintrc.cjs',
            '.eslintrc.yaml',
            '.eslinsrc.yml',
            '.eslinsrc.json',
        })
    end,
}

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
                    nls.builtins.formatting.eslint_d.with(eslint_d_config),
                    nls.builtins.formatting.deno_fmt.with({
                        condition = function(utils)
                            return utils.root_has_file({ 'deno.json', 'deno.jsonc' })
                        end,
                    }),
                    nls.builtins.formatting.stylua,
                    nls.builtins.diagnostics.flake8,
                    nls.builtins.diagnostics.eslint_d.with(eslint_d_config),
                    nls.builtins.code_actions.eslint_d.with(eslint_d_config),
                },
            }
        end,
    },
}
