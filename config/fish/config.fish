# Run Sway if not already running, not root, not in SSH and not in tmux
if test -z "$WAYLAND_DISPLAY" -a (id -u "$USER") -ne 0 -a -z "$SSH_CLIENT" -a -z "$TMUX" -a (tty) = /dev/tty1
    flog "Starting Sway..."
    exec startsway
end
