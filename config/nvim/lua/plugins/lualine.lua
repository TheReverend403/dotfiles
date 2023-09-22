return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "navarasu/onedark.nvim",
  },
  opts = {
    options = {
      theme = "onedark",
      icons_enabled = false,
      section_separators = "",
      component_separators = { left = "|", right = "|" },
    },
  },
}
