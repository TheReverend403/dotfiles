return {{
    "mhartington/formatter.nvim",
    config = function()
        local vim = vim
        local formatter = require("formatter")
        local prettier_config = function()
            return {
                exe = "prettier",
                args = {"--stdin-filepath", vim.fn.shellescape(vim.api.nvim_buf_get_name(0)), "--single-quote"},
                stdin = true
            }
        end

        local formatter_config = {
            lua = {
                function()
                   return {
                     exe = "stylua",
                     args = {  "-" },
                     stdin = true,
                   }
                 end,
            },
            ['*'] = {
                require("formatter.filetypes.any").lsp_format,
                require('formatter.filetypes.any').remove_trailing_whitespace
            }
        }
        local common_ft = {"css", "scss", "html", "java", "javascript", "javascriptreact", "typescript",
                          "typescriptreact", "markdown", "markdown.mdx", "json", "yaml", "xml", "svg", "svelte"}
        for _, ft in ipairs(common_ft) do
            formatter_config[ft] = {prettier_config}
        end
        -- Setup functions
        formatter.setup({
            logging = true,
            filetype = formatter_config,
            log_level = 2
        })
    end
}}
