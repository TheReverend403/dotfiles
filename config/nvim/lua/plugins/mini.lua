return {
  "echasnovski/mini.nvim",
  opts = {},
  config = function()
    require("mini.basics").setup({
      mappings = {
        basic = false,
      },
    })
  end,
}
