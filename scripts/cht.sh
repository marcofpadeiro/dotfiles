#!/bin/bash

languages="javascript typescript rust go c bash markdown css php html csharp java python tmux" 
coreutils="ls cat chmod man awk grep bc tr cd mv mkdir rm ln dd df find tar less diff sed kill xargs"

if [ -z "$1" ]
then
    selected=$(echo -e "$languages $coreutils" | tr " " "\n" | fzf)
else 
    selected=$1
fi

read -p "Query: " query

if ! [[ -n "$query" ]] 
then
    tmux kill-pane
fi

if [ "$selected" == "sh" ]; then
    selected="bash"
fi

if echo "$languages" | grep -qs $selected; then
    bash -c "curl cht.sh/$selected/$(echo "$query" | tr " " "+") | less -R"
else
    bash -c "curl cht.sh/$selected~$(echo "$query" | tr " " "+") | less -R"
fi
