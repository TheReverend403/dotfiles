vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

vim.keymap.set("n", "<leader>q", ":qa!<CR>", {})
vim.keymap.set("n", "<leader>s", ":w<CR>", {})
vim.keymap.set("n", "<leader>sa", ":wa<CR>", { silent = true, noremap = true })

-- nvim-tree
vim.keymap.set("n", "<leader>n", ":NvimTreeToggle<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>nr", ":NvimTreeRefresh<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>nf", ":NvimTreeFindFile<CR>", { silent = true, noremap = true })

-- bufferline.nvim
vim.keymap.set("n", "<leader>]", ":BufferLineCycleNext<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>[", ":BufferLineCyclePrev<CR>", { silent = true, noremap = true })

-- trouble.nvim
vim.keymap.set("n", "<leader>xx", function()
  require("trouble").open()
end)
vim.keymap.set("n", "<leader>xw", function()
  require("trouble").open("workspace_diagnostics")
end)
vim.keymap.set("n", "<leader>xd", function()
  require("trouble").open("document_diagnostics")
end)
vim.keymap.set("n", "<leader>xq", function()
  require("trouble").open("quickfix")
end)
vim.keymap.set("n", "<leader>xl", function()
  require("trouble").open("loclist")
end)
vim.keymap.set("n", "gR", function()
  require("trouble").open("lsp_references")
end)
