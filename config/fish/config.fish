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
test -s "$HOME/.config/fish/aliases.fish"; and source "$HOME/.config/fish/aliases.fish"

## Local, untracked config
test -s "$HOME/.config/fish/local.fish"; and source "$HOME/.config/fish/local.fish"

## Login session initialisation
if status --is-login
    ## /etc/profile compatibility
    env -i HOME=$HOME dash -l -c 'export -p' | sed -e "/PWD/d; /PATH/s/'//g;/PATH/s/:/ /g;s/=/ /;s/^export/set -x/" | source

    ## Prevent Wine from adding menu entries and desktop links.
    set -x WINEDLLOVERRIDES 'winemenubuilder.exe=d'

    ## Default programs
    set -x BROWSER firefox

    # Disable GTK3 accessibility
    set -x NO_AT_BRIDGE 1

    ## Python
    set -x VIRTUAL_ENV_DISABLE_PROMPT true

    ## Jetbrains
    ## Use Oracle JDK rather than OpenJDK because shitty font rendering.
    set -l ORACLE_JDK "/usr/lib/jvm/oracle-jdk-bin-1.8"
    set -x PHPSTORM_JDK $ORACLE_JDK
    set -x IDEA_JDK $ORACLE_JDK
    set -x PYCHARM_JDK $ORACLE_JDK

    ## NodeJS
    set -x NPM_PACKAGES "$HOME/.npm-packages"
    set -x NODE_PATH "$NPM_PACKAGES/lib/node_modules:$NODE_PATH"

    set -x GOPATH "$HOME/.go-lib"

    ## PATH
    set -l user_dirs "$GOPATH/bin" "$NPM_PACKAGES/bin" "$HOME/.fzf/bin" "$HOME/.composer/vendor/bin" "$HOME/.cargo/bin" "$HOME/.local/bin"

    ## Only add items to $PATH that actually exist. Prevents fish from complaining.
    for dir in $user_dirs
        test -d "$dir"; and set fish_user_paths "$dir" $fish_user_paths
    end

    ## Rust racer
    command -v racer >/dev/null; and set -gx RUST_SRC_PATH "$HOME/src/rust/src"

    ## Less
    set -x LESS '-RSXMgwsI~'

    # Run X if not already running, not root and not in SSH
    if test -z "$DISPLAY" -a (id -u $USER) -ne 0 -a -z "$SSH_CLIENT"
        fish_msg 'Starting X...'
        exec startx >/dev/null ^&1
    end
end
