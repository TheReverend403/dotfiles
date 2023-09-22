local autocmd = vim.api.nvim_create_autocmd

autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*sway/conf.d/*" },
  command = "set filetype=swayconfig",
})

autocmd("Filetype", {
  pattern = { "gitcommit", "markdown", "text" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})
