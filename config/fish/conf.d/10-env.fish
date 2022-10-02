## Prevent Wine from adding menu entries and desktop links.
set -x WINEDLLOVERRIDES 'winemenubuilder.exe=d'


## Python
set -x VIRTUAL_ENV_DISABLE_PROMPT true
set -x POETRY_HOME "$XDG_DATA_HOME/poetry"
set -x IPYTHONDIR "$XDG_CONFIG_HOME/jupyter"
set -x JUPYTER_CONFIG_DIR "$IPYTHONDIR"

# Go
set -x GOPATH "$XDG_DATA_HOME/go"

# Rust
set -x RUSTUP_HOME "$XDG_DATA_HOME/rustup"
set -x CARGO_HOME "$XDG_DATA_HOME/cargo"

# XDG partial support.
set -x ASPELL_CONF "per-conf $XDG_CONFIG_HOME/aspell/aspell.conf; personal $XDG_CONFIG_HOME/aspell/en.pws; repl $XDG_CONFIG_HOME/aspell/en.prepl"
set -x NPM_CONFIG_USERCONFIG "$XDG_CONFIG_HOME/npm/npmrc"
set -x NODE_REPL_HISTORY "$XDG_CACHE_HOME/node_repl_history"
set -x SQLITE_HISTORY "$XDG_CACHE_HOME/sqlite_history"
set -x PSQLRC "$XDG_CONFIG_HOME/pg/psqlrc"
set -x PGSERVICEFILE "$XDG_CONFIG_HOME/pg/pg_service.conf"
set -x PGPASSFILE "$XDG_CONFIG_HOME/pg/pgpass"
set -x PSQL_HISTORY "$XDG_CACHE_HOME/pg/psql_history"
set -x GRADLE_USER_HOME "$XDG_DATA_HOME/gradle"
set -x GTK2_RC_FILES "$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
set -x INPUTRC "$XDG_CONFIG_HOME/readline/inputrc"
set -x MYSQL_HISTFILE "$XDG_DATA_HOME/mysql_history"
set -x LESSHISTFILE -
set -x PARALLEL_HOME "$XDG_CONFIG_HOME/parallel"
set -x NPM_PACKAGES "$XDG_DATA_HOME/npm"

## PATH
set -U fish_user_paths "$HOME/.local/bin" "$XDG_DATA_HOME/poetry/bin" "$CARGO_HOME/bin" "$GOPATH/bin" "$NPM_PACKAGES/bin" "$HOME/.config/composer/vendor/bin" "/usr/local/sbin" "/usr/local/bin"
