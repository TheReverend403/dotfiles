set +o history
fish_path=$(command -v fish)

if [[ $- != *i* ]]; then
    return
fi

[[ ! -z "$fish_path" ]] && [[ -x $fish_path ]] && SHELL=$fish_path exec $fish_path
