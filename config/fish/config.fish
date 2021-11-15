# Run X if not already running, not root, not in SSH and not in tmux
if test -z "$DISPLAY" -a (id -u "$USER") -ne 0 -a -z "$SSH_CLIENT" -a -z "$TMUX" -a (tty) = "/dev/tty1"
    set -l xlauncher startx
    if available sx
        set xlauncher sx
    end

    flog "Starting X11 with $xlauncher..."
    exec $xlauncher >/dev/null 2>&1
end
