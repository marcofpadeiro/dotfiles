# startup config
xset r rate 220 40 &
setxkbmap -layout us,pt -option 'grp:alt_shift_toggle' &
setxkbmap -option 'ctrl:nocaps' &
xinput set-prop 10 "libinput Natural Scrolling Enabled" 1 &
xinput set-prop 10 "libinput libinput Tapping Enabled" 1 &

# startup programs
flameshot &

# bar
while true; do
    /bin/bash $HOME/.config/dwm/bar.sh
    sleep 5
done &

# start dwm
exec dwm >/dev/null 2>&1
