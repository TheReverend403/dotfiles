return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    disable_netrw = true,
    hijack_cursor = true,
    sync_root_with_cwd = true,
    update_focused_file = {
      enable = true,
    },
    filters = {
      git_ignored = false,
    },
    view = {
      preserve_window_proportions = true,
    },
    git = {
      enable = false,
    },
    renderer = {
      root_folder_label = false,
      icons = {
        git_placement = "after",
      },
    },
  },
  config = function(_, opts)
    require("nvim-tree").setup(opts)

    vim.keymap.set("n", "<leader>n", ":NvimTreeToggle<CR>", { silent = true, noremap = true })
    vim.keymap.set("n", "<leader>nr", ":NvimTreeRefresh<CR>", { silent = true, noremap = true })
    vim.keymap.set("n", "<leader>nf", ":NvimTreeFindFile<CR>", { silent = true, noremap = true })

    -- Autoclose when last buffer
    vim.api.nvim_create_autocmd("BufEnter", {
      group = vim.api.nvim_create_augroup("NvimTreeClose", { clear = true }),
      pattern = "NvimTree_*",
      callback = function()
        local layout = vim.api.nvim_call_function("winlayout", {})
        if
          layout[1] == "leaf"
          and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), "filetype") == "NvimTree"
          and layout[3] == nil
        then
          vim.cmd("confirm quit")
        end
      end,
    })
  end,
}
