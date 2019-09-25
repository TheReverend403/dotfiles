function fish_prompt
    if test -n "$SSH_CLIENT"
        set_color -i green
        printf 'ssh:'
    end

    if test (id -u) -eq 0
        set_color -i brred
    end

    printf $USER
    set_color normal; set_color -i

    printf '@%s ' (hostname -s)
    set_color normal

    set_color $fish_color_cwd
    printf "%s" (prompt_pwd)

    set_color normal
    printf '> '
end
