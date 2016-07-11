# Git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch yellow

# Git status chars
set __fish_git_prompt_char_dirtystate '~'
set __fish_git_prompt_char_stagedstate '→'
set __fish_git_prompt_char_stashstate '←'
set __fish_git_prompt_char_upstream_ahead '↑'
set __fish_git_prompt_char_upstream_behind '↓'

function fish_right_prompt
    printf '%s' (__fish_git_prompt)

    if set -q VIRTUAL_ENV
        printf ' (venv:%s%s%s)' (set_color $fish_color_cwd) $VIRTUAL_ENV (set_color normal)
    end
end
