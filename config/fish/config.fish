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

## Python
set -x VIRTUAL_ENV_DISABLE_PROMPT true

# Go
set -x GOPATH "$XDG_DATA_HOME/go"

# Rust
set -x RUSTUP_HOME "$XDG_DATA_HOME/rustup"

# XDG partial support.
set -x ASPELL_CONF "per-conf $XDG_CONFIG_HOME/aspell/aspell.conf; personal $XDG_CONFIG_HOME/aspell/en.pws; repl $XDG_CONFIG_HOME/aspell/en.prepl"
set -x CARGO_HOME "$XDG_DATA_HOME/cargo"
set -x CUDA_CACHE_PATH "$XDG_CACHE_HOME/nv"
set -x NPM_CONFIG_USERCONFIG "$XDG_CONFIG_HOME/npm/npmrc"
set -x NODE_REPL_HISTORY "$XDG_CACHE_HOME/node_repl_history"
set -x SQLITE_HISTORY "$XDG_CACHE_HOME/sqlite_history"
set -x PSQLRC "$XDG_CONFIG_HOME/pg/psqlrc"
set -x PGSERVICEFILE "$XDG_CONFIG_HOME/pg/pg_service.conf"
set -x PGPASSFILE "$XDG_CONFIG_HOME/pg/pgpass"
set -x PSQL_HISTORY "$XDG_CACHE_HOME/pg/psql_history"
set -x GRADLE_USER_HOME "$XDG_DATA_HOME/gradle"
set -x IPYTHONDIR "$XDG_CONFIG_HOME/jupyter"
set -x JUPYTER_CONFIG_DIR "$IPYTHONDIR"
set -x _JAVA_OPTIONS -Djava.util.prefs.userRoot="$XDG_CONFIG_HOME/java"
set -x GTK2_RC_FILES "$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
set -x INPUTRC "$XDG_CONFIG_HOME/readline/inputrc"
set -x MYSQL_HISTFILE "$XDG_DATA_HOME/mysql_history"
set -x LESSHISTFILE -
set -x PARALLEL_HOME "$XDG_CONFIG_HOME/parallel"

# Weechat 3.2 implements XDG properly.
if available weechat; and test (weechat -v) -lt "3.2"
    set -x WEECHAT_HOME "$XDG_CONFIG_HOME/weechat"
end

## PATH
set -U fish_user_paths "$HOME/.local/bin" "$XDG_DATA_HOME/poetry/bin" "$CARGO_HOME/bin" "$GOPATH/bin" "$NPM_PACKAGES/bin" "$HOME/.config/composer/vendor/bin" "/usr/local/sbin" "/usr/local/bin"

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
