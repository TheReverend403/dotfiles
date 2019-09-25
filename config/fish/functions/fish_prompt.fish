function fish_prompt
    if test -n "$SSH_CLIENT"
        set_color -i green
        printf 'ssh:'
    end

    if test (id -u) -eq 0
        set name_color brred
    else
        set name_color normal
    end

    set_color $name_color; set_color -i
    printf '%s@%s ' $USER (hostname -s)
    set_color normal

    set_color $fish_color_cwd
    printf "%s" (prompt_pwd)

    set_color normal
    printf '> '
end
