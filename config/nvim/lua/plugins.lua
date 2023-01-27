local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd([[packadd packer.nvim]])
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()
return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'gpanders/editorconfig.nvim'
    use 'haya14busa/is.vim'
    use 'sheerun/vim-polyglot'
    use {
        'navarasu/onedark.nvim',
        config = function()
            local onedark = require('onedark')
            onedark.setup({
                code_style = { comments = 'none' }
            })
            onedark.load()
        end
    }
    use {
        'nvim-lualine/lualine.nvim',
        requires = {
            'navarasu/onedark.nvim',
            'nvim-tree/nvim-web-devicons'
        },
        options = { theme = 'onedark' },
        config = function()
            require('lualine').setup()
        end
    }
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    if packer_bootstrap then
        require('packer').sync()
    end

    vim.cmd([[
        augroup packer_user_config
            autocmd!
            autocmd BufWritePost plugins.lua source <afile> | PackerCompile
        augroup end
    ]])
end)
