#!/bin/bash
tmux --new-session $(find ~ ~/uni ~/personal -maxdepth 1 -type d | fzf)


