return {
  {
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
      local onedark = require('onedark')
      onedark.setup({
        code_style = { comments = 'none' },
      })
      onedark.load()
    end,
  },
}
