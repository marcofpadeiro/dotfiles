#!/bin/bash

languages="javascript typescript rust go c bash markdown css php html csharp java python tmux" 
coreutils="ls cat chmod man awk grep bc tr cd mv mkdir rm ln dd df find tar less diff sed kill xargs"


languages="javascript typescript rust go c bash markdown css php html csharp java python tmux" 
coreutils="ls cat chmod man awk grep bc tr cd mv mkdir rm ln dd df find tar less diff sed kill xargs"

selected=$(echo -e "$languages $coreutils" | tr " " "\n" | fzf)

if ! echo "$languages $coreutils" | grep -qs $selected; then
tmux kill-pane -t 1

fi



read -p "Query: " query

if echo "$languages" | grep -qs $selected; then
    bash -c "curl cht.sh/$selected/$(echo "$query" | tr " " "+") | less -R"
else
    bash -c "curl cht.sh/$selected~$(echo "$query" | tr " " "+") | less -R"
fi

tmux kill-pane -t 1



