## Print a pretty-formatted message
function fish_msg
    if count $argv >/dev/null
        printf "[%s*%s] %s\n" (set_color green) (set_color normal) $argv
    end
end

function available --description 'Returns 0 if a given command is present and executable, 1 otherwise.'
    command -v $argv >/dev/null ^&1
end

## Fish UI
set fish_greeting ''
set fish_color_param default
set fish_color_command default

## Aliases
test -s "$HOME/.config/fish/aliases.fish"; and source "$HOME/.config/fish/aliases.fish"

## Local, untracked config
test -s "$HOME/.config/fish/local.fish"; and source "$HOME/.config/fish/local.fish"

if status --is-interactive
    # https://github.com/morhetz/gruvbox/issues/76
    set -l GRUVBOX_SCRIPT $HOME/.vim/bundle/gruvbox/gruvbox_256palette.sh
    if test -f $GRUVBOX_SCRIPT
        sh $GRUVBOX_SCRIPT
    end
end

## Login session initialisation
if status --is-login
    ## /etc/profile compatibility
    env -i HOME="$HOME" dash -l -c 'export -p' | sed -e "/PWD/d; /PATH/s/'//g;/PATH/s/:/ /g;s/=/ /;s/^export/set -x/" | source

#    set -l profile_env /etc/profile.env
#    if test -s "$profile_env"
#        source "$profile_env"
#    end

    ## Prevent Wine from adding menu entries and desktop links.
    set -x WINEDLLOVERRIDES 'winemenubuilder.exe=d'

    ## Default programs
    if test -z "$BROWSER"
        if available firefox
            set -x BROWSER firefox
        else if available chromium
            set -x BROWSER chromium
        else if available lynx
            set -x BROWSER lynx
        else if available w3m
            set -x BROWSER w3m
        end
    end

    # flags for Gentoo and Debian's Chromium wrappers
    set -x CHROMIUM_FLAGS "--disable-background-networking --disable-component-extensions-with-background-pages"
    set -x EDITOR vim

    # Disable GTK3 accessibility
    set -x NO_AT_BRIDGE 1

    # Make Qt use the GTK file chooser
    set -x QT_QPA_PLATFORMTHEME gtk

    ## Python
    set -x VIRTUAL_ENV_DISABLE_PROMPT true

    ## NodeJS
    set -x NPM_PACKAGES "$HOME/.npm-packages"
    set -x NODE_PATH "$NPM_PACKAGES/lib/node_modules:$NODE_PATH"

    # Go
    set -x GOPATH "$HOME/.go"

    ## PATH
    set -l user_dirs "$HOME/.local/conda/bin" "$GOPATH/bin" "$NPM_PACKAGES/bin" "$HOME/.composer/vendor/bin" "$HOME/.cargo/bin" "$HOME/.local/bin"

    ## Only add items to $PATH that actually exist.
    for dir in $user_dirs
        test -d "$dir"; and set -gx fish_user_paths "$dir" $fish_user_paths
    end

    available rustup; and available rustc; and set -gx RUST_SRC_PATH (rustc --print sysroot)/lib/rustlib/src/rust/src

    if available conda
        if test -z "$CONDA_FISH"
            set -gx CONDA_FISH (conda info --root)/etc/fish/conf.d/conda.fish
        end
        set -gx CONDA_LEFT_PROMPT 1
    end

    ## Less
    set -x LESS '-RSXMgwsI~'
    set -x LESSHISTFILE /dev/null

    # Run X if not already running, not root, not in SSH and not in tmux
    if test -z "$DISPLAY" -a (id -u "$USER") -ne 0 -a -z "$SSH_CLIENT" -a -z "$TMUX"
        if available startx
            fish_msg 'Starting X...'
            exec startx >/dev/null ^&1
        end
    end
end

# Source conda.fish here since functions can't be defined in login shell initialisation apparently.
test -n "$CONDA_FISH"; and test -s $CONDA_FISH; and source $CONDA_FISH
