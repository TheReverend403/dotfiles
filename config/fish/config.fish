## Fish UI
set fish_greeting
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
    command -v $argv > /dev/null 2>&1
end

## Login session initialisation
if status is-login
    ## /etc/profile compatibility
    env -i HOME="$HOME" /bin/sh -l -c 'export -p' | sed -e "/PWD/d; /PATH/s/'//g;/PATH/s/:/ /g;s/=/ /;s/^export/set -x/" | source

    ## Prevent Wine from adding menu entries and desktop links.
    set -x WINEDLLOVERRIDES 'winemenubuilder.exe=d'

    # Disable GTK3 accessibility
    set -x NO_AT_BRIDGE 1
    
    # Make QT apps use the GTK file chooser.
    set -x QT_QPA_PLATFORMTHEME qt5ct

    ## Python
    set -x VIRTUAL_ENV_DISABLE_PROMPT true

    ## NodeJS
    set -x NPM_PACKAGES "$HOME/.local"
    set -x NODE_PATH "$NPM_PACKAGES/lib/node_modules:$NODE_PATH"

    # Go
    set -x GOPATH "$HOME/.local/lib/go"

    ## PATH
    set -U fish_user_paths "$HOME/.local/bin" "$HOME/.poetry/bin" "$GOPATH/bin" "$NPM_PACKAGES/bin" "$HOME/.config/composer/vendor/bin" "/usr/local/sbin" "/usr/local/bin"

    ## Less
    set -x LESS '-RSXMgwsI~'
    set -x LESSHISTFILE /dev/null
    set -x LESS_TERMCAP_mb (tput bold; tput setaf 5)
    set -x LESS_TERMCAP_md (tput bold; tput setaf 5)
    set -x LESS_TERMCAP_me (tput sgr0)
    set -x LESS_TERMCAP_so (tput bold; tput setaf 5; tput setab 0)
    set -x LESS_TERMCAP_se (tput rmso; tput sgr0)
    set -x LESS_TERMCAP_ue (tput rmul; tput sgr0)
    set -x LESS_TERMCAP_us (tput smul; tput bold; tput setaf 7)
end

## Aliases
test -s "$__fish_config_dir/aliases.fish"; and source "$__fish_config_dir/aliases.fish"

## Local, untracked config
test -s "$__fish_config_dir/local.fish"; and source "$__fish_config_dir/local.fish"

if status is-login
    # Run X if not already running, not root, not in SSH and not in tmux
    if test -z "$DISPLAY" -a (id -u "$USER") -ne 0 -a -z "$SSH_CLIENT" -a -z "$TMUX" -a (tty) = "/dev/tty1"
        if available startx
            exec startx
        end
    end
end
