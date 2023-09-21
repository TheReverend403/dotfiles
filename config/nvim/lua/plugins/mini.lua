return {
  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.basics').setup({
        mappings = {
          basic = false,
        },
      })
      require('mini.comment').setup()
      require('mini.surround').setup()
      require('mini.pairs').setup()
      require('mini.trailspace').setup()
    end,
  },
}
