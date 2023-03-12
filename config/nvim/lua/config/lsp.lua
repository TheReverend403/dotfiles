local lsp = require('lspconfig')
local lsp_defaults = lsp.util.default_config
local mason_packages = {}
local servers = {
    { 'bashls' },
    { 'jsonls' },
    { 'yamlls' },
    { 'lua_ls',
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

for _, server in pairs(servers) do
    -- Make sure Mason supports a server before trying to install it.
    local ok, _ = pcall(require, 'mason-lspconfig.server_configurations.' .. server[1])
    if ok then
        table.insert(mason_packages, server[1])
    end
end

require('mason').setup()
require('mason-lspconfig').setup({
    ensure_installed = mason_packages,
    automatic_installation = true
})

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
