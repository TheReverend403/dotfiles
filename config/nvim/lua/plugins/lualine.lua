return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "navarasu/onedark.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    options = {
      theme = "onedark",
      section_separators = "",
      component_separators = { left = "|", right = "|" },
      disabled_filetypes = { "Lazy", "NvimTree", "toggleterm" },
    },
  },
}
