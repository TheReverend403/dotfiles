return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "dcampos/nvim-snippy",
    "dcampos/cmp-snippy",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-cmdline",
    "petertriho/cmp-git",
    "honza/vim-snippets",
    "onsails/lspkind.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  event = { "InsertEnter", "CmdlineEnter" },
  config = function()
    local cmp = require("cmp")
    local snippy = require("snippy")
    local lspkind = require("lspkind")

    cmp.setup({
      snippet = {
        expand = function(args)
          snippy.expand_snippet(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif snippy.can_expand_or_advance() then
            snippy.expand_or_advance()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif snippy.can_jump(-1) then
            snippy.previous()
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp", keyword_length = 3 },
        { name = "snippy", keyword_length = 3 },
      }, {
        name = "buffer",
        keyword_length = 3,
        option = {
          -- Avoid accidentally running on big files
          get_bufnrs = function()
            local buf = vim.api.nvim_get_current_buf()
            local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
            if byte_size > 1024 * 1024 then -- 1 Megabyte max
              return {}
            end
            return { buf }
          end,
        },
        { name = "path", keyword_length = 3 },
      }),
      formatting = {
        format = lspkind.cmp_format({
          mode = "symbol_text",
          maxwidth = 50,
          ellipsis_char = "...",
          menu = {
            buffer = "",
            nvim_lsp = "λ",
            snippy = "",
            path = "",
            cmdline = "",
          },
        }),
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
    })

    cmp.setup.filetype({ "gitcommit", "gitrebase" }, {
      sources = cmp.config.sources({
        { name = "git", keyword_length = 3 },
      }, {
        { name = "buffer", keyword_length = 3 },
      }),
    })

    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer", keyword_length = 3 },
      },
    })

    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path", keyword_length = 3 },
      }, {
        { name = "cmdline", keyword_length = 3 },
      }),
    })
  end,
}
