# startup config
xset r rate 220 40 &
setxkbmap -layout us,pt -option 'grp:alt_shift_toggle' &
setxkbmap -option 'ctrl:nocaps' &

# startup programs
flameshot &
/usr/lib/polkit-kde-authentication-agent-1 &
corectrl &
xrandr --output DisplayPort-0 --mode 1920x1080 --rate 240 &

# bar
while true; do
    /bin/bash $HOME/.config/dwm/bar.sh
    sleep 5
done &

# start dwm
exec dwm >/dev/null 2>&1
