function fish_prompt
    if test -n "$SSH_CLIENT"
        set_color green
        printf 'ssh:'
    end

    if test (id -u) -eq 0
        set name_color brred
    else
        set name_color normal
    end

    set_color $name_color
    printf $USER

    set_color normal
    printf '@%s ' (hostname -s)

    set_color $fish_color_cwd
    printf "%s" (prompt_pwd)

    set_color normal
    printf '> '
end
