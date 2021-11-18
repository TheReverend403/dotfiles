alias rsync 'rsync --progress -h'
alias grep 'grep --color=auto'
alias more 'less'
alias df 'df -h'
alias du 'du -c -h'
alias mkdir 'mkdir -p -v'
alias ping 'ping -c 5'
alias ls 'ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'

if command -sq nvim
    alias vim nvim
    alias vimdiff 'nvim -d'
end
