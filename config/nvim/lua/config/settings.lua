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
o.updatetime = 250

o.timeout = true
o.timeoutlen = 300

o.undodir = vim.fn.stdpath("data") .. "/undo"
o.undofile = true
