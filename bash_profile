set +o history
fish_path=$(command -v fish)

if [[ $- != *i* ]]; then
    return
fi

[[ -z "$BASH_EXECUTION_STRING" ]] && [[ -x $fish_path ]] && SHELL=$fish_path exec $fish_path
