## Print a message with a nice little fish icon
function fish_msg
    printf "[%s*%s] %s\n" (set_color green) (set_color normal) $argv
end

## Fish UI
set fish_greeting ''
set fish_color_param default
set fish_color_command default

## Aliases
if test -f $HOME/.config/fish/aliases.fish
    . $HOME/.config/fish/aliases.fish
end

## Login session initialisation
if status --is-login
    ## /etc/profile compatibility
    env -i HOME=$HOME dash -l -c 'export -p' | sed -e "/PWD/d; /PATH/s/'//g;/PATH/s/:/ /g;s/=/ /;s/^export/set -x/" | source

    ## Prevent Wine from adding menu entries and desktop links.
    set -gx WINEDLLOVERRIDES 'winemenubuilder.exe=d'

    ## Default programs
    set -gx BROWSER firefox

    ## Rust racer
    set -gx RUST_SRC_PATH /usr/src/rust/src

    ## NodeJS
    set -gx NPM_PACKAGES $HOME/.npm-packages
    set -gx NODE_PATH $NPM_PACKAGES/lib/node_modules:$NODE_PATH

    ## PATH
    set -l user_dirs $NPM_PACKAGES/bin $HOME/.cargo/bin $HOME/.fzf/bin $HOME/.composer/vendor/bin $HOME/.cargo/bin $HOME/.local/bin $HOME/.gem/ruby/2.1.0/bin $HOME/.gem/ruby/2.0.0/bin /usr/lib/ccache/bin $HOME/.local/bin

    for dir in $user_dirs
        if test -d $dir
            set fish_user_paths $dir $fish_user_paths
        end
    end

    ## Less
    set -gx LESS '-RSXMsi'
    set -gx LESS_TERMCAP_mb (tput bold; tput setaf 2)
    set -gx LESS_TERMCAP_md (tput bold; tput setaf 13)
    set -gx LESS_TERMCAP_me (tput sgr0)
    set -gx LESS_TERMCAP_se (tput rmso; tput sgr0)
    set -gx LESS_TERMCAP_us (tput smul; tput bold; tput setaf 7)
    set -gx LESS_TERMCAP_ue (tput rmul; tput sgr0)
    set -gx LESS_TERMCAP_mr (tput rev)
    set -gx LESS_TERMCAP_mh (tput dim)
    set -gx LESS_TERMCAP_ZN (tput ssubm)
    set -gx LESS_TERMCAP_ZV (tput rsubm)
    set -gx LESS_TERMCAP_ZO (tput ssupm)
    set -gx LESS_TERMCAP_ZW (tput rsupm)

    # Run X if not already running and not in SSH
    if test -z "$DISPLAY"
        if not set -q $SSH_CLIENT
            fish_msg 'Starting X...'
            exec startx > /dev/null ^&1
        end
    end
end
