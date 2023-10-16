set -x XDG_DATA_DIRS "$HOME/.local/share:$XDG_DATA_DIRS"

# XDG partial support.
set -x ASPELL_CONF "per-conf $XDG_CONFIG_HOME/aspell/aspell.conf; personal $XDG_CONFIG_HOME/aspell/en.pws; repl $XDG_CONFIG_HOME/aspell/en.prepl"
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
set -x GNUPGHOME "$XDG_CONFIG_HOME/gnupg"

# Set BROWSER to the first available command.
if not set -q $BROWSER
    set -l browsers firefox-bin firefox chromium-bin chromium
    for browser in $browsers
        if command -q $browser
            set -gx BROWSER $browser
            break
        end
    end
end

# Prefer neovim.
if command -q nvim
    set -x EDITOR nvim
end

# Prevent Wine adding menu entries and desktop links.
set -x WINEDLLOVERRIDES 'winemenubuilder.exe=d'

# Python
set -x VIRTUAL_ENV_DISABLE_PROMPT true
set -x IPYTHONDIR "$XDG_CONFIG_HOME/jupyter"
set -x JUPYTER_CONFIG_DIR "$IPYTHONDIR"
set -x POETRY_HOME "$XDG_DATA_HOME/poetry"
fish_add_path "$POETRY_HOME/bin"

# Go
set -x GOPATH "$XDG_DATA_HOME/go"
fish_add_path "$GOPATH/bin"

# Rust
set -x RUSTUP_HOME "$XDG_DATA_HOME/rustup"
set -x CARGO_HOME "$XDG_DATA_HOME/cargo"
fish_add_path "$CARGO_HOME/bin"

# Node
set -x NODE_REPL_HISTORY "$XDG_DATA_HOME/node_repl_history"
set -x NPM_PACKAGES "$XDG_DATA_HOME/npm"
set -x NPM_CONFIG_USERCONFIG "$XDG_CONFIG_HOME/npm/npmrc"
fish_add_path "$NPM_PACKAGES/bin"

# PHP
fish_add_path "$XDG_CONFIG_HOME/composer/vendor/bin"

# JB toolbox symlinks
fish_add_path "$XDG_DATA_HOME/JetBrains/scripts"

# Use --move here so ~/.local/bin is always used first and /usr/* is always last.
fish_add_path --move --append /usr/local/sbin /usr/local/bin
fish_add_path --move "$HOME/.local/bin"
