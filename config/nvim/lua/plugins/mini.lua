return {
  "echasnovski/mini.nvim",
  config = function()
    require("mini.basics").setup({
      mappings = {
        basic = false,
      },
    })
  end,
}
