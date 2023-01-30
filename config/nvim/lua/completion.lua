local cmp = require('cmp')
local select_opts = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
    snippet = {
        expand = function(args)
            require('snippy').expand_snippet(args.body)
        end,
    },
    mapping = {
        ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
        ['<Down>'] = cmp.mapping.select_next_item(select_opts),

        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),

        ['<C-Space>'] = cmp.mapping.complete(),

        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({
            select = false,
        }),

        ['<Tab>'] = cmp.mapping(function(fallback)
            local col = vim.fn.col('.') - 1

            if cmp.visible() then
                cmp.select_next_item(select_opts)
            elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
                fallback()
            else
                cmp.complete()
            end
        end, { 'i', 's' }),

        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item(select_opts)
            else
                fallback()
            end
        end, { 'i', 's' }),
    },
    sources = {
        { name = 'path' },
        { name = 'nvim_lsp', keyword_length = 3 },
        { name = 'buffer', keyword_length = 3 },
        { name = 'snippy', keyword_length = 2 },
    },
    formatting = {
        fields = { 'menu', 'abbr', 'kind' },
        format = function(entry, item)
            local menu_icon = {
                nvim_lsp = 'λ',
                snippy = '⋗',
                buffer = '',
                path = '🖫',
                cmdline = '',
            }

            item.menu = menu_icon[entry.source.name]
            return item
        end,
    },
    window = {
        documentation = cmp.config.window.bordered()
    },
})

cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})

require('mason').setup()
require('mason-lspconfig').setup({
    ensure_installed = { 'bashls', 'jsonls', 'yamlls' },
    automatic_installation = true
})

local lspconfig = require('lspconfig')
local lsp_defaults = lspconfig.util.default_config

lsp_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lsp_defaults.capabilities,
    require('cmp_nvim_lsp').default_capabilities()
)

lspconfig.bashls.setup({})
lspconfig.jsonls.setup({})
lspconfig.yamlls.setup({})

vim.diagnostic.config({
    severity_sort = true,
    float = {
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
})

vim.o.completeopt = 'menu,menuone,noselect'
