local autocmd = vim.api.nvim_create_autocmd

autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*/sway/conf.d/*" },
  command = "set filetype=swayconfig",
})

autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*/sites-{enabled,available}/*" },
  command = "set filetype=caddyfile",
})
