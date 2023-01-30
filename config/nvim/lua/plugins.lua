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
            'dcampos/cmp-snippy',
            'dcampos/nvim-snippy',
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
        }
    },
}
