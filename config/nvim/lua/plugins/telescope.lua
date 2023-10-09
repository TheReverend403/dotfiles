return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "stevearc/dressing.nvim",
      opts = {},
    },
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },
  },
  opts = {
    defaults = {
      mappings = {
        i = {
          ["<C-u>"] = false,
          ["<C-d>"] = false,
        },
      },
    },
  },
  config = function(_, opts)
    require("telescope").setup(opts)
    pcall(require("telescope").load_extension, "fzf")

    local map = require("helpers.keys").map
    local builtin = require("telescope.builtin")

    map("n", "<leader><space>", builtin.buffers, "Open buffers")
    map("n", "<leader>/", function()
      -- You can pass additional configuration to telescope to change theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        previewer = false,
      }))
    end, "Search in current buffer")

    map("n", "<leader>sf", function()
      return builtin.find_files({ hidden = true })
    end, "Files")

    map("n", "<leader>sr", builtin.oldfiles, "Recently opened")
    map("n", "<leader>sh", builtin.help_tags, "Help")
    map("n", "<leader>sw", builtin.grep_string, "Current word")
    map("n", "<leader>sg", builtin.live_grep, "Grep")
    map("n", "<leader>sd", builtin.diagnostics, "Diagnostics")

    map("n", "<C-p>", builtin.keymaps, "Search keymaps")
  end,
}
