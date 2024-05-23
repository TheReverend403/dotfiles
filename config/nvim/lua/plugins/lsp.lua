return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    vim.list_extend(opts.servers, {
      bashls = {},
      lua_ls = {
        Lua = {
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
        },
      },
      cssls = {},
      html = {},
    })
  end,
}
