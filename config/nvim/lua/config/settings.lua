local o = vim.o
local wo = vim.wo

o.report = 0

o.showmode = false
o.modeline = false

o.expandtab = true
o.softtabstop = 4
o.shiftwidth = 4
o.shiftround = true

o.breakindent = true

o.completeopt = 'menuone,noselect'

wo.signcolumn = 'yes'

wo.number = true

o.ignorecase = true
o.smartcase = true

o.clipboard = 'unnamedplus'

o.mouse = 'a'

o.undofile = true
o.backup = false

o.list = true
o.listchars = 'tab:| ,extends:>,precedes:<,nbsp:·,trail:·'

o.lazyredraw = true
o.redrawtime = 1500
o.timeoutlen = 300
o.updatetime = 250
