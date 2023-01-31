-- Support Gentoo app-vim/* syntax plugins.
vim.opt.rtp:append('/usr/share/vim/vimfiles')

require('dep') {
    'gpanders/editorconfig.nvim',
    'haya14busa/is.vim',
    'sheerun/vim-polyglot',
    {
        'echasnovski/mini.nvim',
        function()
            require('mini.basics').setup({
                mappings = {
                    basic = false
                }
            })
            require('mini.comment').setup()
            require('mini.surround').setup()
            require('mini.pairs').setup()
        end,
    },
    {
        'navarasu/onedark.nvim',
        function()
            local onedark = require('onedark')
            onedark.setup({
                code_style = { comments = 'none' }
            })
            onedark.load()
        end,
    },
    {
        'nvim-lualine/lualine.nvim',
        function()
            require('lualine').setup({
                options = { theme = 'onedark' },
            })
        end,
        requires = {
            'nvim-tree/nvim-web-devicons'
        },
    },
    {
        'hrsh7th/nvim-cmp',
        function()
            require('completion')
        end,
        requires = {
            'neovim/nvim-lspconfig',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-cmdline',
            'dcampos/cmp-snippy',
            'dcampos/nvim-snippy',
            'honza/vim-snippets',
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'onsails/lspkind.nvim',
        }
    },
    {
        'norcalli/nvim-colorizer.lua',
        function()
            require('colorizer').setup()
        end
    },
    {
        'akinsho/toggleterm.nvim',
        function()
            require('toggleterm').setup({
                open_mapping = '<A-`>',
                persist_size = false,
                -- Set size to 1/3 of the available space.
                size = function(term)
                    if term.direction == 'horizontal' then
                        return vim.o.lines / 3
                    elseif term.direction == 'vertical' then
                        return vim.o.columns / 3
                    end
                end,
            })
        end
    },
}