local fn = vim.fn
local path = fn.stdpath('data') .. '/site/pack/deps/opt/dep'

if fn.empty(fn.glob(path)) > 0 then
    fn.system({ 'git', 'clone', '--depth=1', 'https://github.com/chiyadev/dep', path })
end

vim.cmd('packadd dep')
