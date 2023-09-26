vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

vim.keymap.set("n", "<leader>s", ":w<CR>", { noremap = true })
vim.keymap.set("n", "<leader>ss", ":wa<CR>", { noremap = true })

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, {})
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, {})
vim.keymap.set("n", "<leader>x", vim.diagnostic.open_float, {})
vim.keymap.set("n", "<leader>xx", vim.diagnostic.setloclist, {})
