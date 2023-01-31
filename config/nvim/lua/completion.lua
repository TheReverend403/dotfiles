local cmp = require('cmp')
local snippy = require('snippy')
local lspkind = require('lspkind')

local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

local select_opts = { behavior = cmp.SelectBehavior.Select }
cmp.setup({
    snippet = {
        expand = function(args)
            snippy.expand_snippet(args.body)
        end,
    },
    mapping = {
        ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
        ['<Down>'] = cmp.mapping.select_next_item(select_opts),

        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),

        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({
            select = false,
        }),

        -- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#nvim-snippy
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item(select_opts)
            elseif snippy.can_expand_or_advance() then
                snippy.expand_or_advance()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { 'i', 's' }),

        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item(select_opts)
            elseif snippy.can_jump(-1) then
                snippy.previous()
            else
                fallback()
            end
        end, { 'i', 's' }),
    },
    sources = {
        { name = 'path', keyword_length = 3 },
        { name = 'nvim_lsp', keyword_length = 2 },
        { name = 'buffer', keyword_length = 3 },
        { name = 'snippy', keyword_length = 2 },
    },
    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol_text',
            maxwidth = 50,
            ellipsis_char = '...',
            menu = ({
                buffer = "",
                nvim_lsp = "λ",
                snippy = "",
                path = "",
                cmdline = "",
            })
        })
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
        { name = 'path', keyword_length = 3 }
    }, {
        { name = 'cmdline', keyword_length = 3 }
    })
})

local servers = {
    { 'bashls' },
    { 'jsonls' },
    { 'yamlls' },
    { 'sumneko_lua',
        settings = {
            Lua = {
                diagnostics = {
                    globals = {
                        'vim',
                        'on_attach'
                    },
                },
                telemetry = {
                    enable = false,
                },
            },
        }
    },
    { 'dockerls' },
    { 'cssls' },
    { 'ansiblels' },
    { 'html' },
    { 'marksman' }
}

local mason_packages = {}
for _, server in pairs(servers) do
    -- Make sure Mason supports a server before trying to install it.
    local ok, _ = pcall(require, 'lspconfig.server_configurations.' .. server[1])
    if ok then
        table.insert(mason_packages, server[1])
    end
end

require('mason').setup()
require('mason-lspconfig').setup({
    ensure_installed = mason_packages,
    automatic_installation = true
})

local lsp = require('lspconfig')
local lsp_defaults = lsp.util.default_config
lsp_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lsp_defaults.capabilities,
    require('cmp_nvim_lsp').default_capabilities()
)

for _, server in pairs(servers) do
    local config = lsp[server[1]]

    local server_executable = config.document_config.default_config.cmd
    if(type(server_executable) ~= "table") then
        break
    end

    server_executable = server_executable[1]
    if(vim.fn.executable(server_executable) == 1) then
        local opts = {
            on_attach = on_attach,
            capabilities = lsp_defaults.capabilities,
            flags = {
                debounce_text_changes = 150
            }
        }

        for k, v in pairs(server) do
            if type(k) ~= 'number' then
                opts[k] = v
            end
        end

        config.setup(opts)
    end
end

vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.diagnostic.config({
    severity_sort = true,
    float = {
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
})
