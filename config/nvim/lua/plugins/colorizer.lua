local css_common = {
  names = true,
  css = true,
  css_fn = true,
  sass = { enable = true },
}

return {
  "NvChad/nvim-colorizer.lua",
  opts = {
    user_default_options = {
      names = false,
      mode = "virtualtext",
    },
    filetypes = {
      "*",
      css = css_common,
      scss = css_common,
      sass = css_common,
      less = css_common,
      "!lazy",
    },
  },
}
