return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  version = false,
  opts = {
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
    highlight = {
      enable = true,
      use_languagetree = true,
    },
    indent = {
      enable = true,
    },
    autotag = {
      enable = true,
    },
    context_commentstring = {
      enable = true,
      enable_autocmd = false,
    },
    refactor = {
      highlight_definitions = {
        enable = true,
      },
      highlight_current_scope = {
        enable = false,
      },
    },
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}
