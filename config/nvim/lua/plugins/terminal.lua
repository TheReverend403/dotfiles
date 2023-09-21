local function set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('n', '<esc>', [[i]], opts)
  vim.keymap.set('t', '<C-w><Left>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-w><Down>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-w><Up>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-w><Right>', [[<Cmd>wincmd l<CR>]], opts)
end

return {
  {
    'akinsho/toggleterm.nvim',
    config = function()
      require('toggleterm').setup({
        open_mapping = '<A-`>',
        persist_size = false,
        on_open = function(t)
          set_terminal_keymaps()
        end,
        -- Set size to 1/3 of the available space.
        size = function(term)
          if term.direction == 'horizontal' then
            return vim.o.lines / 3
          elseif term.direction == 'vertical' then
            return vim.o.columns / 3
          end
        end,
      })
    end,
  },
}
