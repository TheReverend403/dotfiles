if [[ $- != *i* ]]; then
    return
fi

[ -x /bin/fish ] && SHELL=/bin/fish exec /bin/fish
