## Print a pretty-formatted message
function fish_msg
    if count $argv >/dev/null
        printf "[%s*%s] %s\n" (set_color green) (set_color normal) $argv
    end
end

## Fish UI
set fish_greeting ''
set fish_color_param default
set fish_color_command default

## Aliases
if test -s $HOME/.config/fish/aliases.fish
    source $HOME/.config/fish/aliases.fish
end

## Local, untracked config
if test -s $HOME/.config/fish/local.fish
    source $HOME/.config/fish/local.fish
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

    ## Python
    set -gx PIP_DOWNLOAD_CACHE $HOME/.cache/pip
    set -gx VIRTUAL_ENV_DISABLE_PROMPT true

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

    # Run X if not already running, not root and not in SSH
    if test -z "$DISPLAY" -a (id -u $USER) -ne 0; and set -q $SSH_CLIENT
        fish_msg 'Starting X...'
        exec startx >/dev/null ^&1
    end
end
