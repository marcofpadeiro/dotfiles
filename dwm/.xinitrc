
# startup programs
flameshot &
nm-applet &

xinput set-prop 10 "libinput Natural Scrolling Enabled" 1 &
xinput set-prop 10 "libinput Tapping Enabled" 1 &
xset r rate 220 40 &

# bar
while true; do
    /bin/bash $HOME/.config/dwm/bar.sh
    sleep 5
done &

# start dwm
exec dwm >/dev/null 2>&1
