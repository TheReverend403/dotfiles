#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/*; do
        # Fuck dbus
        if echo "$f" | grep -vq dbus; then
            [ -x "$f" ] && . "$f"
        fi
    done
    unset f
fi

xrandr --output DVI-0 --mode 1366x768 --pos 1920x365 --output HDMI-0 --mode 1920x1080 --dpi 91 --pos 0x0

if [ -f ~/.Xresources ]; then
    xrdb -load -I $HOME ~/.Xresources
fi

numlockx on
xsetroot -cursor_name left_ptr
setxkbmap -option compose:ralt,caps:escape
unclutter --timeout 5 --exclude-root --fork
xset +fp ~/.local/share/fonts/

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

#autocutsel -fork -selection PRIMARY
#autocutsel -fork -selection CLIPBOARD

exec awesome
