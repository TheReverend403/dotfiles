vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

vim.keymap.set("n", "<leader>q", ":qa!<CR>", {})
vim.keymap.set("n", "<leader>s", ":w<CR>", {})

vim.keymap.set("n", "<leader>n", ":NvimTreeToggle<CR>", {})
vim.keymap.set("n", "<leader>nr", ":NvimTreeRefresh<CR>", {})
vim.keymap.set("n", "<leader>nf", ":NvimTreeFindFile<CR>", {})
