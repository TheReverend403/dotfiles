function fish_prompt
    if test -n "$SSH_CLIENT"
        set_color -i green
        printf '(ssh)'
    end

    if test -n "$SUDO_USER"
        set_color -i red
        printf '(root)'
    end

    set_color normal
    set_color -i
    printf '%s@%s ' $USER (hostname -s)
    set_color normal

    set_color $fish_color_cwd
    printf "%s" (prompt_pwd)

    set_color normal
    printf '> '
end
