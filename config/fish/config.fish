## Fish UI
set fish_greeting ''
set fish_color_param default
set fish_color_command default 
set fish_color_cwd magenta
set fish_color_operator green --bold
set fish_color_end $fish_color_operator
set fish_color_comment brblack --italics
set fish_color_quote bryellow
set fish_color_error red
set fish_color_search_match --background=brblack
set fish_color_escape white
set fish_pager_color_prefix brgreen
set fish_pager_color_progress brgreen
set fish_pager_color_description white --italics

function available --description 'Returns 0 if a given command is present and executable, 1 otherwise.'
    command -v $argv >/dev/null ^&1
end

## Aliases
test -s "$__fish_config_dir/aliases.fish"; and source "$__fish_config_dir/aliases.fish"

## Local, untracked config
test -s "$__fish_config_dir/local.fish"; and source "$__fish_config_dir/local.fish"

## Login session initialisation
if status is-login
    ## /etc/profile compatibility
    env -i HOME="$HOME" /bin/sh -l -c 'export -p' | sed -e "/PWD/d; /PATH/s/'//g;/PATH/s/:/ /g;s/=/ /;s/^export/set -x/" | source

    ## Prevent Wine from adding menu entries and desktop links.
    set -x WINEDLLOVERRIDES 'winemenubuilder.exe=d'

    # Disable GTK3 accessibility
    set -x NO_AT_BRIDGE 1

    # Make Qt use the GTK file chooser
    set -x QT_QPA_PLATFORMTHEME qt5ct

    ## Python
    set -x VIRTUAL_ENV_DISABLE_PROMPT true

    ## NodeJS
    set -x NPM_PACKAGES "$HOME/.local"
    set -x NODE_PATH "$NPM_PACKAGES/lib/node_modules:$NODE_PATH"

    # Go
    set -x GOPATH "$HOME/.local/lib/go"

    ## PATH
    set -l user_dirs "$HOME/.poetry/bin" "$GOPATH/bin" "$NPM_PACKAGES/bin" "$HOME/.config/composer/vendor/bin" "$HOME/.local/bin" "/usr/local/bin" "/usr/local/sbin"

    ## Only add items to $PATH that actually exist. Prevents fish complaining.
    for dir in $user_dirs
        test -d "$dir"; and set fish_user_paths "$dir" $fish_user_paths
    end

    ## Less
    set -x LESS '-RSXMgwsI~'
    set -x LESSHISTFILE /dev/null

    # Run X if not already running, not root, not in SSH and not in tmux
    if test -z "$DISPLAY" -a (id -u "$USER") -ne 0 -a -z "$SSH_CLIENT" -a -z "$TMUX"
        if available startx
            exec startx >/dev/null ^&1
        end
    end
end
