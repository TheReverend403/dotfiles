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
test -s $HOME/.config/fish/aliases.fish; and source $HOME/.config/fish/aliases.fish

## Local, untracked config
test -s $HOME/.config/fish/local.fish; and source $HOME/.config/fish/local.fish

## Login session initialisation
if status --is-login
    ## /etc/profile compatibility
    env -i HOME=$HOME dash -l -c 'export -p' | sed -e "/PWD/d; /PATH/s/'//g;/PATH/s/:/ /g;s/=/ /;s/^export/set -x/" | source

    ## Prevent Wine from adding menu entries and desktop links.
    set -gx WINEDLLOVERRIDES 'winemenubuilder.exe=d'

    ## Default programs
    set -gx BROWSER firefox

    ## Rust racer
    which racer >/dev/null ^&1; and set -gx RUST_SRC_PATH $HOME/src/rust/src

    # Disable GTK3 accessibility
    set -gx NO_AT_BRIDGE 1

    ## Python
    set -gx VIRTUAL_ENV_DISABLE_PROMPT true

    ## PhpStorm
    set -gx PHPSTORM_JDK $JAVA_HOME

    ## NodeJS
    set -gx NPM_PACKAGES $HOME/.npm-packages
    set -gx NODE_PATH $NPM_PACKAGES/lib/node_modules:$NODE_PATH

    ## PATH
    set -l user_dirs $NPM_PACKAGES/bin $HOME/.fzf/bin $HOME/.composer/vendor/bin $HOME/.cargo/bin $HOME/.local/bin

    ## Only add items to $PATH that actually exist. Prevents fish from complaining.
    for dir in $user_dirs
        test -d $dir; and set fish_user_paths $dir $fish_user_paths
    end

    ## Less
    set -gx LESS '-RSXMsi'

    # Run X if not already running, not root and not in SSH
    if test -z "$DISPLAY" -a (id -u $USER) -ne 0
        if set -q $SSH_CLIENT
            fish_msg 'Starting X...'
            exec startx >/dev/null ^&1
        end
    end
end
