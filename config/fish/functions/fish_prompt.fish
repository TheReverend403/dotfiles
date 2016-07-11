function fish_prompt
    set last_status $status

    # Just calculate this once, to save a few cycles when displaying the prompt.
    if not set -q __fish_prompt_hostname
        set -g __fish_prompt_hostname (hostname -s)
    end

    printf '%s@%s ' (whoami) "$__fish_prompt_hostname"

    set_color $fish_color_cwd
    printf '%s' (prompt_pwd)

    set_color normal
    printf '> '
end
