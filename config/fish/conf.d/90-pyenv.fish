set -x PYENV_ROOT "$XDG_DATA_HOME/pyenv"
if test -e "$PYENV_ROOT"
    fish_add_path "$PYENV_ROOT/bin"
    pyenv init - | source
end
