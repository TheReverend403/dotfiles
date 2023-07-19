function _G.set_terminal_keymaps()
    local opts = { buffer = 0 }
    vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
    vim.keymap.set('n', '<esc>', [[i]], opts)
    vim.keymap.set('t', '<C-w><Left>', [[<Cmd>wincmd h<CR>]], opts)
    vim.keymap.set('t', '<C-w><Down>', [[<Cmd>wincmd j<CR>]], opts)
    vim.keymap.set('t', '<C-w><Up>', [[<Cmd>wincmd k<CR>]], opts)
    vim.keymap.set('t', '<C-w><Right>', [[<Cmd>wincmd l<CR>]], opts)
end
