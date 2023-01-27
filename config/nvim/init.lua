local fn = vim.fn
local o = vim.o
local g = vim.g

g.mapleader = ','

o.shell = '/bin/bash'

o.termguicolors = true

o.cursorline = true
o.report = 0

o.number = true
o.showmode = false
o.modeline = false

o.splitbelow = true
o.splitright = true

o.hlsearch = true

o.expandtab = true
o.softtabstop = 4
o.shiftwidth = 4
o.shiftround = true

o.clipboard = 'unnamedplus'
o.pastetoggle = '<F3>'

o.mouse = false

o.undofile = true
o.backup = true
o.backupdir = string.format('%s/backup', fn.stdpath('data'))

require('plugins')
