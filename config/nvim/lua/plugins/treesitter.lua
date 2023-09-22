return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "lua",
        "python",
        "javascript",
        "bash",
        "dockerfile",
        "fish",
        "gitignore",
        "html",
        "json",
        "css",
        "scss",
        "toml",
        "yaml",
        "xml",
        "make",
        "php",
      },
      auto_install = false,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
