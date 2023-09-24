return {
  "navarasu/onedark.nvim",
  priority = 1000,
  opts = {
    term_colors = false,
    code_style = { comments = "none" },
  },
  config = function(_, opts)
    local onedark = require("onedark")
    onedark.setup(opts)
    onedark.load()
  end,
}
