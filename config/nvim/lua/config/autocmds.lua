local autocmd = vim.api.nvim_create_autocmd

autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = { '*sway/conf.d/*' },
  command = 'set filetype=swayconfig',
})

autocmd('Filetype', {
  pattern = { 'gitcommit', 'markdown', 'text' },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank({
      higroup = 'IncSearch',
      timeout = '500',
    })
  end,
})

autocmd('BufWritePre', {
  pattern = '',
  command = ':silent lua vim.lsp.buf.format()',
})

-- Remove whitespace on save
autocmd('BufWritePre', {
  pattern = '',
  command = ':%s/\\s\\+$//e',
})
