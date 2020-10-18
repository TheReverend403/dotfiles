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

## Prevent Wine from adding menu entries and desktop links.
set -x WINEDLLOVERRIDES 'winemenubuilder.exe=d'

# Disable GTK3 accessibility
set -x NO_AT_BRIDGE 1

set -x QT_QPA_PLATFORMTHEME gtk2

## Python
set -x VIRTUAL_ENV_DISABLE_PROMPT true

# Go
set -x GOPATH "$HOME/.local/lib/go"

## PATH
set -U fish_user_paths "$HOME/.local/bin" "$HOME/.poetry/bin" "$GOPATH/bin" "$NPM_PACKAGES/bin" "$HOME/.config/composer/vendor/bin" "/usr/local/sbin" "/usr/local/bin"

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
