return {
  {
    "folke/which-key.nvim",
    opts = {
      triggers_blacklist = {
        -- Leave cutlass alone.
        i = { "j", "k", "d", "D", "s", "S" },
        v = { "j", "k", "d", "D", "s", "S", " ", "g" },
        n = { "d", "D", "s", "S", "m" },
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.register({
        ["<leader>"] = {
          f = { name = "File" },
          s = { name = "Search" },
          l = { name = "LSP" },
          u = { name = "UI" },
          d = { name = "Delete Buffers" },
          q = { name = "Quit" },
        },
      })
    end,
  },
}
