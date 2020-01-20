#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/*; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

if [ -f ~/.Xresources ]; then
    xrdb -load -I $HOME ~/.Xresources
fi

numlockx on
xsetroot -cursor_name left_ptr
setxkbmap -option compose:ralt,caps:escape
unclutter --timeout 5 --exclude-root --fork
xset +fp ~/.local/share/fonts/
# Make left side buttons for mouse act as middle click. Thanks steelseries for the weak af wheel.
xinput --set-button-map 10 1 2 3 4 5 6 7 2 2 10 11 12 13 14 15 16

unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/gnupg/S.gpg-agent.ssh"
fi

## {{ Refresh gpg-agent tty in case user switches into an X session
# Wait for gpg-agent to actually start
while ! pidof gpg-agent >/dev/null 2>&1
do
    sleep 0.1
done

export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye >/dev/null
## }}

thunar --daemon &
exec awesome
