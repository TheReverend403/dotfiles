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

    vim.diagnostic.config({
      severity_sort = true,
      update_in_insert = true,
      float = {
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    })

    -- This function gets run when an LSP connects to a particular buffer.
    local on_attach = function(_, bufnr)
      local lsp_map = require("helpers.keys").lsp_map
      local telescope_builtin = require("telescope.builtin")

      lsp_map("<leader>lr", vim.lsp.buf.rename, bufnr, "Rename symbol")
      lsp_map("<leader>la", vim.lsp.buf.code_action, bufnr, "Code action")
      lsp_map("<leader>ld", vim.lsp.buf.type_definition, bufnr, "Type definition")
      lsp_map("<leader>ls", telescope_builtin.lsp_document_symbols, bufnr, "Document symbols")

      lsp_map("gd", vim.lsp.buf.definition, bufnr, "Go to definition")
      lsp_map("gr", telescope_builtin.lsp_references, bufnr, "Go to references")
      lsp_map("gI", vim.lsp.buf.implementation, bufnr, "Go to implementation")
      lsp_map("K", vim.lsp.buf.hover, bufnr, "Hover documentation")
      lsp_map("gD", vim.lsp.buf.declaration, bufnr, "Go to declaration")
    end

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
          on_attach = on_attach,
          capabilities = capabilities,
          settings = servers[server_name],
          filetypes = (servers[server_name] or {}).filetypes,
        })
      end,
    })
  end,
}
