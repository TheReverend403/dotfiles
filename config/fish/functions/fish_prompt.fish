function fish_prompt
    set last_status $status
    printf '%s@%s ' (whoami) (hostname)

    set_color $fish_color_cwd
    printf '%s' (prompt_pwd)

    set_color normal
    printf '> '
end
