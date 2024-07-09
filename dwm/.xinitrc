#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then







    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then







    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# startup programs
flameshot &
nm-applet &
redshift -l 39.5450597:-8.9763512 &

xinput set-prop 10 "libinput Natural Scrolling Enabled" 1 &
xinput set-prop 10 "libinput Tapping Enabled" 1 &
xinput set-prop 11 'libinput Accel Speed' -0.6 &

xset r rate 220 40 &

# /usr/bin/xcalib -d :0 /usr/share/color/icc/N140HCG_GQ2.icm

# bar
while true; do
    /bin/bash $HOME/.config/dwm/bar.sh
    sleep 5
done &


# start dwm
exec dwm >/dev/null 2>&1
