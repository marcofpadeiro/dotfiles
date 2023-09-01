#!/bin/bash

xset r rate 220 40 & 
setxkbmap -option 'grp:alt_shift_toggle' -layout us,pt & 
setxkbmap -option ctrl:nocaps & 
xinput set-prop 'Elan Touchpad' 'libinput Tapping Enabled' 1 &
xinput set-prop 'Elan Touchpad' 'libinput Natural Scrolling Enabled' 1 & 
sxhkd & 


