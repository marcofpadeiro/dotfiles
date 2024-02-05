#!/bin/bash

current_layout=$(swaymsg -t get_inputs | grep xkb_layouts | awk '{print $2}' | tr -d '[],"')
if [ "$current_layout" == "us" ]; then
    new_layout="pt"
else
    new_layout="us"
fi

swaymsg input '*' xkb_layout "$new_layout"

