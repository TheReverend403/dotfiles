#!/usr/bin/env bash
set +o history
fish_path=$(command -v fish)

if [[ $- != *i* ]]; then
    return
fi

# Drop into fish only if the parent process is not fish. Allows dropping directly into bash from fish without having to use --norc
[[ $(ps --no-header --pid=$PPID --format=cmd) != *"/fish" ]] && [[ -x $fish_path ]] && SHELL=$fish_path exec "$fish_path"
