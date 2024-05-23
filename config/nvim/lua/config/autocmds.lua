local autocmd = vim.api.nvim_create_autocmd

autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*sway/conf.d/*" },
  command = "set filetype=swayconfig",
})
