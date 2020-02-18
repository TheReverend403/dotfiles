function ssht --description 'Launches a remote tmux session or attaches to an existing one.'
    ssh -t $argv tmux new -A -s ssh
end
