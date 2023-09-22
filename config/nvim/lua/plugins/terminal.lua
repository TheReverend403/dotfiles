local function set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
  vim.keymap.set("n", "<esc>", [[i]], opts)
  vim.keymap.set("t", "<C-w><Left>", [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set("t", "<C-w><Down>", [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set("t", "<C-w><Up>", [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set("t", "<C-w><Right>", [[<Cmd>wincmd l<CR>]], opts)
end

return {
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup({
        open_mapping = "<A-`>",
        persist_size = false,
        on_open = function(_)
          set_terminal_keymaps()
        end,
        -- Set size to 1/3 of the available space.
        size = function(term)
          if term.direction == "horizontal" then
            return vim.o.lines / 3
          elseif term.direction == "vertical" then
            return vim.o.columns / 3
          end
        end,
      })
    end,
  },
  {
    "willothy/flatten.nvim",
    -- https://github.com/willothy/flatten.nvim#toggleterm
    opts = function()
      local saved_terminal

      return {
        window = {
          open = "alternate",
        },
        callbacks = {
          should_block = function(argv)
            -- Note that argv contains all the parts of the CLI command, including
            -- Neovim's path, commands, options and files.
            -- See: :help v:argv

            -- In this case, we would block if we find the `-b` flag
            -- This allows you to use `nvim -b file1` instead of
            -- `nvim --cmd 'let g:flatten_wait=1' file1`
            return vim.tbl_contains(argv, "-b")
          end,
          pre_open = function()
            local term = require("toggleterm.terminal")
            local termid = term.get_focused_id()
            saved_terminal = term.get(termid)
          end,
          post_open = function(bufnr, winnr, ft, is_blocking)
            if is_blocking and saved_terminal then
              -- Hide the terminal while it's blocking
              saved_terminal:close()
            else
              -- If it's a normal file, just switch to its window
              vim.api.nvim_set_current_win(winnr)
            end

            -- If the file is a git commit, create one-shot autocmd to delete its buffer on write
            -- If you just want the toggleable terminal integration, ignore this bit
            if ft == "gitcommit" or ft == "gitrebase" then
              vim.api.nvim_create_autocmd("BufWritePost", {
                buffer = bufnr,
                once = true,
                callback = vim.schedule_wrap(function()
                  vim.api.nvim_buf_delete(bufnr, {})
                end),
              })
            end
          end,
          block_end = function()
            -- After blocking ends (for a git commit, etc), reopen the terminal
            vim.schedule(function()
              if saved_terminal then
                saved_terminal:open()
                saved_terminal = nil
              end
            end)
          end,
        },
      }
    end,
    priority = 1001,
  },
}
