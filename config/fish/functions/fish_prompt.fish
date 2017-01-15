function fish_prompt
    set last_status $status

    if test -n "$SSH_CLIENT"
        set_color magenta
        printf 'ssh:'
        set_color normal
    end

    if test -n "$SUDO_USER"
        set_color red
        printf 'sudo:'
        set_color normal
    end

    printf '%s@%s ' $USER (hostname -s)

    set_color cyan
    printf '%s' (prompt_pwd)

    set_color normal
    printf '> '
end
