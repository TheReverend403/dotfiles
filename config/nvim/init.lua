require('bootstrap')
require('plugins')
require('keymaps')

local fn = vim.fn
local o = vim.o

o.report = 0

o.showmode = false
o.modeline = false

o.expandtab = true
o.softtabstop = 4
o.shiftwidth = 4
o.shiftround = true

o.clipboard = 'unnamedplus'
o.pastetoggle = '<F3>'

o.mouse = false

o.backupdir = string.format('%s/backup', fn.stdpath('data'))
