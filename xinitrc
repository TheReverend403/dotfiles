#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/*; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

xrandr --output DVI-0 --mode 1366x768 --pos 1920x312 --output HDMI-0 --mode 1920x1080 --pos 0x0
xgamma -gamma 1.1

if [ -x ~/.fehbg ]; then
    ~/.fehbg
fi

if [ -f ~/.Xresources ]; then
    xrdb -merge -I $HOME ~/.Xresources
fi

numlockx on
xsetroot -cursor_name arrow

if ! pgrep -x -u "${USER}" gpg-agent >/dev/null 2>&1; then
  gpg-connect-agent /bye >/dev/null 2>&1
fi

unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/gnupg/S.gpg-agent.ssh"
fi

# Refresh gpg-agent tty in case user switches into an X session
export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye >/dev/null

exec awesome
