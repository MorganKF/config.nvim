return {
    'nvim-neotest/neotest',
    'nvim-neotest/neotest-jest',
    'rouge8/neotest-rust',
    opts = {
        adapters = {
            ['neotest-jest'] = {},
            ['neotest-rust'] = {},
        },
    },
}
