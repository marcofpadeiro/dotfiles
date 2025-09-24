# ~/.bash_profile
# Run startx only on tty1 so SSH sessions / other ttys stay normal
xss-lock -- xsecurelock &
if [[ -z $DISPLAY ]] && [[ $(tty) == /dev/tty1 ]]; then
    exec startx
fi

