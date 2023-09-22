return {
  "norcalli/nvim-colorizer.lua",
  opts = {
    { "*" },
    { names = false },
  },
  config = function()
    require("colorizer").setup()
  end,
}
