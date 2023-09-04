local function create_ftdetect_autocmds()
    vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
        pattern = {"*sway/conf.d/*"},
        command = "set filetype=swayconfig",
    })
end

create_ftdetect_autocmds()
