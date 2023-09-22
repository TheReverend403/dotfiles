vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

vim.keymap.set("n", "<leader>q", ":qa!<CR>", {})
vim.keymap.set("n", "<leader>s", ":w<CR>", {})

vim.keymap.set("n", "<leader>n", ":NvimTreeToggle<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>nr", ":NvimTreeRefresh<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>nf", ":NvimTreeFindFile<CR>", { silent = true, noremap = true })

vim.keymap.set("n", "<leader>]", ":BufferLineCycleNext<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>[", ":BufferLineCyclePrev<CR>", { silent = true, noremap = true })
