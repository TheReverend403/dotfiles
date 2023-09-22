return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "williamboman/mason.nvim", config = true },
    "williamboman/mason-lspconfig.nvim",
    "folke/neodev.nvim",
  },
  config = function()
    local servers = {
      bashls = {},
      jsonls = {},
      yamlls = {},
      lua_ls = {
        Lua = {
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
        },
      },
      dockerls = {},
      docker_compose_language_service = {},
      cssls = {},
      ansiblels = {},
      html = {},
      marksman = {},
      ruff_lsp = {},
      tsserver = {},
    }

    require("neodev").setup()

    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    -- Ensure the servers above are installed
    local mason_lspconfig = require("mason-lspconfig")

    mason_lspconfig.setup({
      ensure_installed = vim.tbl_keys(servers),
    })

    mason_lspconfig.setup_handlers({
      function(server_name)
        require("lspconfig")[server_name].setup({
          capabilities = capabilities,
          on_attach = on_attach,
          settings = servers[server_name],
          filetypes = (servers[server_name] or {}).filetypes,
        })
      end,
    })
  end,
}
