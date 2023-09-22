return {
  "stevearc/conform.nvim",
  opts = {
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "isort", "black" },
      javascript = { { "prettierd", "prettier" } },
      css = { { "prettierd", "prettier" } },
      less = { { "prettierd", "prettier" } },
      scss = { { "prettierd", "prettier" } },
      html = { { "prettierd", "prettier" } },
      yaml = { { "prettierd", "prettier" } },
      markdown = { "mdformat" },
      sh = { "shfmt", "shellcheck" },
      bash = { "shfmt", "shellcheck" },
      fish = { "fish_indent" },
      ["*"] = { "trim_whitespace", "trim_newlines" },
    },
  },
  config = function(_, opts)
    require("conform.formatters.shfmt").args = { "-i", "4", "-filename", "$FILENAME" }
    require("conform").setup(opts)
  end,
}
