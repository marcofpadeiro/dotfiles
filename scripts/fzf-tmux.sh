#!/bin/bash

use_find() {
    local args=("$@")
    local depth="${args[-1]}"
    unset "args[${#args[@]}-1]"

    for root in "${args[@]}"; do
        find "$root" -mindepth 1 -maxdepth "$depth" \
            \( -type d -name '.*' -prune \) -o -type d -print
    done
}

# usage: directories first, then depth
depth1=$(use_find "$HOME/personal" "$HOME/dotfiles" 1)
depth2=$(use_find "$HOME/uni" 2)
echo "$depth1"
echo "$depth2"

session=$(echo -e "$depth1\n$depth2\n$HOME/dotfiles" | fzf)
session_name=$(basename "$session" | tr . _)

if ! tmux has-session -t "$session_name" 2>/dev/null; then
    tmux new-session -d -s "$session_name" -c "$session" -n nvim 'nvim'

    tmux new-window -t "$session_name":2 -c "$session" -n zsh 'zsh'

    tmux new-window -t "$session_name":3 -c "$session" -n git 'lazygit'

    tmux select-window -t "$session_name":1
fi

if [ -n "${TMUX-}" ]; then
    tmux switch-client -t "$session_name"
else
    tmux attach-session -t "$session_name"
fi
