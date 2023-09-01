#!/bin/bash

session=$(find ~ ~/personal ~/uni ~/dotfiles -maxdepth 1 -type d | fzf)
session_name=$(basename "$session" | tr . _) 

if ! tmux has-session -t "$session_name" 2> /dev/null; then
    tmux new-session -d -s "$session_name" -c "$session"
    tmux send-keys -t "$session_name" "nvim" Enter
    tmux new-window -t "$session_name" -c "$session" -d
fi

if [[ "${TMUX-}" != '' ]];
then
    tmux switch-client -t "$session_name"
fi

tmux attach-session -t "$session_name"

