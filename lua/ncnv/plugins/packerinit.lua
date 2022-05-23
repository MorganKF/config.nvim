local present, packer = pcall(require, 'packer')

if not present then
    print('Installing packer...')

    local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'
    vim.fn.system({
        'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wbthomason/packer.nvim',
        install_path,
    })

    vim.cmd('packadd packer.nvim')
    present, packer = pcall(require, 'packer')

    if present then
        print('Packer successfully installed!')
    else
        error('Error installing packer!\nPath: ' .. install_path .. '\n' .. packer)
    end
end


vim.cmd('packadd packer.nvim')
packer.init({
    git = {
        clone_timeout = 120,
    },
    auto_clean = true,
    compile_on_sync = true,
    autoremove = true,
})

return packer
