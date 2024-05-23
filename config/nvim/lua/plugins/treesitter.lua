return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    if type(opts.ensure_installed) == "table" then
      vim.list_extend(opts.ensure_installed, {
        "bash",
        "html",
        "javascript",
        "lua",
        "query",
        "regex",
        "tsx",
        "vim",
        "fish",
        "gitignore",
        "css",
        "scss",
        "xml",
        "make",
      })
    end
  end,
}
