## Fish UI
set fish_greeting
set fish_color_param default
set fish_color_command default 
set fish_color_cwd magenta
set fish_color_operator brblack
set fish_color_end $fish_color_operator
set fish_color_comment brblack --italics
set fish_color_quote brgreen
set fish_color_error red
set fish_color_search_match --background=brblack
set fish_color_escape white
set fish_pager_color_prefix magenta
set fish_pager_color_progress magenta
set fish_pager_color_description white --italics

function __log
    set_color brwhite --bold
    printf "["
    set_color green --bold
    printf "*"
    set_color brwhite --bold
    printf "] $argv"
    set_color normal
    printf "\n"
end


function available --description 'Returns 0 if a given command is present and executable, 1 otherwise.'
    command -v $argv > /dev/null 2>&1
end


## Env vars
test -s "$__fish_config_dir/env.fish"; and source "$__fish_config_dir/env.fish"


## Aliases
test -s "$__fish_config_dir/aliases.fish"; and source "$__fish_config_dir/aliases.fish"

## Local, untracked config
test -s "$__fish_config_dir/local.fish"; and source "$__fish_config_dir/local.fish"

# Run X if not already running, not root, not in SSH and not in tmux
if test -z "$DISPLAY" -a (id -u "$USER") -ne 0 -a -z "$SSH_CLIENT" -a -z "$TMUX" -a (tty) = "/dev/tty1"
    set -l xlauncher startx
    if available sx
        set xlauncher sx
    end

    __log "Starting X11 with $xlauncher..."
    exec $xlauncher >/dev/null 2>&1
end
