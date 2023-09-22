local o = vim.o

o.report = 0
o.modeline = false

o.expandtab = true
o.softtabstop = 4
o.shiftwidth = 4
o.shiftround = true

o.clipboard = "unnamedplus"

o.list = true
o.listchars = "tab:| ,extends:>,precedes:<,nbsp:·,trail:·"

o.lazyredraw = true
o.redrawtime = 1500
o.timeoutlen = 300
o.updatetime = 250

local disabled_built_ins = {
  "2html_plugin",
  "getscript",
  "getscriptPlugin",
  "gzip",
  "logipat",
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "matchit",
  "tar",
  "tarPlugin",
  "rrhelper",
  "spellfile_plugin",
  "vimball",
  "vimballPlugin",
  "zip",
  "zipPlugin",
  "tutor",
  "rplugin",
  "synmenu",
  "optwin",
  "compiler",
  "bugreport",
  "ftplugin",
}

for _, plugin in pairs(disabled_built_ins) do
  vim.g["loaded_" .. plugin] = 1
end
